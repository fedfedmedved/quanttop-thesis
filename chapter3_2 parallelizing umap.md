## Parallelizing UMAP
From the results of the profiling it is clear which algorithm steps take longest.
These steps are: performance of a KNN search, normalization of distance between data points, initialization of a low-dimensional representation, and optimization of this representation.
In the following each step is analyzed as to how it can best be parallelized for GPUs.

### Parallelization of KNN Search
Finding nearest-neighbors is a common problem and encountered in a wide range of fields, e.g. Machine Learning and Data Analysis.
As a consequence, multiple implementations already exist.
Comparing their performance based on publications is difficult, since provided times depend on the individual system used to measure them, making them incomparable.

In [@annbenchmark] a framework for benchmarking approximate KNN algorithms is introduced.
With it, a selection of implementations are compared in a standardized and reproducible manner.
All implementations are required to provide a Python interface, in order to be used with the framework.
This allows them to be used as a drop-in replacement for the current `nearest_neighbors` method of UMAP.

Unfortunately all but one of the compared implementations only support execution on CPUs.
Since the goal of this thesis is to parallelize UMAP on GPUs, only the GPU algorithm is to be considered further.
The implementation in question is the FAISS library [@faiss], which is also used by t-SNE-CUDA (see [Section 1.2.2](#cudatsne)).
In the benchmarking framework only the CPU version of FAISS is compared, which commonly performs worse than the remaining algorithms.

However, the GPU version of FAISS is shown to be perform well in t-SNE-CUDA [@tsne-cuda].
The use case of KNN search in t-SNE is similar to that in UMAP, which is querying a fixed amount of nearest-neighbors for each data point.
Thus, the performance of utilizing FAISS for UMAP can be expected to be of similar quality.
Concludingly FAISS will be used for a GPU implementation of the `nearest_neighbors` method.

### Parallelization of Distance Normalization
Normalizing the distances between data points by their local connectivity is a task unique to UMAP and not provided by any library.
Therefore a new implementation for GPUs is needed.
@fig:tuna_google_news_fuzzy shows the time taken by the `fuzzy_simplicial_set` method, when UMAP is processing a 500.000 data points big subset of the GoogleNews data set.
It can be seen that most of the time, besides JIT compiling, is spent in a call to the `smooth_knn_dist` method.

Parallelizing `smooth_knn_dist` can be done in a straightforward manner, since the method is "embarrassingly parallel": it processes every data point independently.
This is advantageous for creation of a parallel version, as no extra caution needs to be exercised to avoid data conflicts.

![Time spent by `fuzzy_simplicial_set` when processing 500.000 points of the GoogleNews data set.](figures/chapter3/tuna_google_news_fuzzy.png){width=80% #fig:tuna_google_news_fuzzy}

### Parallelization of Embedding Initialization
@fig:tuna-mnist shows that most time spent by `simplicial_set_embedding` is spent in a call to the `optimize_layout` method.
When profiling UMAP on bigger data sets however, another method emerges that also requires a significant amount of processing time.
As displayed in @fig:tuna_google_news_simplicial, for bigger data sets the method `spectral_layout` requires disproportionately more time than for small data sets.
This can also be seen by the increase of time spent on the method shown in @fig:plot_google_news.

![Time spent by `simplicial_set_embedding` when processing a 500.000 points subset of GoogleNews.](figures/chapter3/tuna_google_news_simplicial.png){width=80% #fig:tuna_google_news_simplicial}

`spectral_layout` initializes the low-dimensional representation, by calculating eigenvectors and -values of the sparse adjacency matrix induced by found KNN neighbors.
Each KNN relation is represented as an edge in a graph.
With additional processing of neighborhood relations, the matrix, albeit being represented in a sparse form, grows.
Processing of the 500.000 point subset of the GoogleNews data set, with a $K$ value of 15 for KNN search, results in a graph that consists of 13.8 million edges.
Calculating all eigenvalues and eigenvectors for this matrix consequently takes a long time.

The spectral initialization allows "faster convergence and greater stability" ([@umap], p. 14), but the embedding also "can be initialized randomly", as the publication states.
Parallelizing the `spectral_layout` method is difficult, since it requires a multitude of numerical operations on sparse matrices and handling of edge cases, such as disconnected graphs.
Considering this, a parallelization of the method is therefore avoided.
Instead, spectral initialization is only used for small data sets.
For data sets bigger than a certain threshold a random intialization is performed.
Considering @fig:plot_google_news, a limit of 100.000 data points is chosen.

![Comparison of UMAP methods on reduced GoogleNews data sets. The Y-axis is scaled logarithmical, so all function plots are distinguishable.](figures/chapter3/plot_google_news.png){width=100% short-caption="Comparison of UMAP methods on reduced GoogleNews data sets." #fig:plot_google_news}

### Parallelization of Embedding Optimization {#methods_optimize_layout}
The remaining time of `simplicial_set_embedding` is mostly accounted for by the call to `optimize_layout`.
It is the essential part of the UMAP algorithm, that creates the low-dimensional representation.
Given a pre-initialized embedding, generated with or without `spectral_layout`, a Stochastic Gradient Descent (SGD) procedure is performed.
Thereby the given embedding is reshaped to better represent the original input data, by repositioning its points.
The ponits are repositioned according to the original data's topology, that is represented in the form of a graph.

The following steps are performed for each iteration of the SGD:
Each edge of the graph is iterated over and sampled with a chance based on the edge's weight.
The two nodes of each edge are represented by two embedding points.
If the edge is sampled in an iteration, then the distance between these two points is calculated.
Depending on whether the distance reflects the weight of the edge, the embedding points are moved closer together or further apart.

Additionally negative sampling is performed for each edge with the same likeliness.
For simpler implementability and better performance, this always coincides with the times that the edge is sampled.
The edge's primary node is used, it is determined by the order in which the edge nodes are stored.
Negative sampling randomly selects embedding points and calculates distances from them to the embedding point associated with the primary node.
This primary node is then repositioned according to the calculated distances, most likely pushing it further away from the randomly selected embedding points, as it is very unlikely to be neighboring to the other points.

For the implementation of this SGD procedure conditional branching is required in multiple places, e.g. upon deciding whether or not to sample an edge.
Branching however negatively impacts the performance of GPUs, since GPUs operate according to the Single Instruction Multiple Data (SIMD) model.
All threads perform the same sequence of commands in parallel, while processing different data points.
If the commands executed contain branching, the threads are no longer guaranteed to execute the same commands.
This requires the GPU to execute every set of branched off threads separately, as only one command can be run by all threads at a time.
In the worst case this leads to sequential execution.

![Shown is a conceptual depiction of the edge pre-filtering procedure.
The edges on which SGD is to be performed are divided in blocks, each assigned to a different thread.
All threads execute process the assigned edges in parallel.
Every thread has a limited local cache.
Edges that are chosen to be sampled, marked in the graphic with black dots, are stored by index in the cache.
These indices are then iterated over during regular SGD, again by all threads in parallel.
Since the local cache is of limited size, the procedure is done iteratively until all edges are checked for potential sampling.](figures/chapter3/prefiltering.png){width=70% #fig:prefiltering short-caption="Conceptual depiction of edge pre-filtering."}

One solution to reduce branching execution for SGD is, to prepare the edges which to sample in a certain iteration by pre-filtering before each operation.
If every thread knows on which edges to perform SGD, then the branching introduced by the probability with which to sample an edge, can be overcome.
@fig:prefiltering explains this concept with a graphical depiction.

Further possibilities to improve the performance of `optimize_layout` are preventing data write conflicts by assigning nodes to threads, and improving cache performance by using shared random values per block of threads.
Both concepts are more implementation focused and therefore presented in [Chapter 4.2.3](#detail_optimize_layout).


