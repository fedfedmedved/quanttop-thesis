## Parallelizing UMAP
From the profiling it is clear that the algorithm steps that take longest to perform are the KNN search, the normalization of distance between data points according to their local connectivity, and the optimization of the low-dimensional representation.
The following sections analyze how these algorithms can be parallelized on GPUs.

<!--|Algorithm step|Equivalent exists in|GPU Parallelization exists|-->
<!--|-------------------|--------------|---------------|-->
<!--|KNN Search|t-SNE|Yes|-->
<!--|Distance Normalization| - | No |-->
<!--|Layout Optimization| - |No|-->

### Parallelization of KNN Search
Finding nearest-neighbors is a common problem and encountered in a wide range of fields, e.g. Machine Learning and Data Analysis.
As a consequence, multiple implementations already exist.
Comparing their performance is difficult, the times given in publications depend on the individual system used to measure them, making them not comparable.

In [@annbenchmark] a framework for benchmarking approximate KNN algorithms is introduced.
With it, a selection of implementations are compared in a standardized and reproducible manner.
All implementations are required to provide a Python interface, in order to be used with the framework.
This allows them to be used as drop-in replacements for the current `nearest_neighbors` method of UMAP.

Unfortunately all but one of the compared implementations only support execution on CPUs.
Since the goal of this thesis is to parallelize UMAP on GPUs, only the GPU algorithm is to be considered further.
The implementation in question is the FAISS library [@faiss], which is also used by t-SNE-CUDA (see [section 1.2.2](#cudatsne)).
In the benchmarking framework only the CPU version of FAISS is compared, which commonly performs worse than the remaining algorithms.

However, the performance of FAISS's GPU version in t-SNE-CUDA is shown to be good [@tsne-cuda].
The use case of KNN search in t-SNE is similar to that in UMAP, which is querying a fixed amount of nearest-neighbors for each data point.
The performance of utilizing FAISS for UMAP can be expected to be similarly good.
Therefore FAISS will be used to implement a modified version of the `nearest_neighbors` method, so that execution is done on the GPU.

### Parallelization of Distance Normalization
Normalizing the distances between data points by their local connectivity is a task unique to UMAP and not provided by any library.
Therefore a new implementation of the `fuzzy_simplicial_set` method for GPUs is needed.

@fig:fuzzy_tuna_googlenews_500k shows the time taken by the `fuzzy_simplicial_set` method, when UMAP is processing a 500.000 data points big subset of the GoogleNews data set.
It can be seen that most of the time not spent on compiling, is spent in a call to the `smooth_knn_dist` method.

![Detailed times of the `fuzzy_simplicial_set` method on the GoogleNews data set.](figures/chapter3/fuzzy_tuna_googlenews_500k.png){#fig:fuzzy_tuna_googlenews_500k short-caption="Detailed times of the `fuzzy_simplicial_set` method on a GoogleNews data subset." width="100%"}

The `smooth_knn_dist` method is what is referred to as "embarrassingly parallel": every data point processed by it can be processed independently.
This is advantageous when creating a parallel version, as no extra caution needs to be exercised to avoid data conflicts.
A straightforward implementation can therefore be done.

### Parallelization of Embedding
@fig:tuna-mnist suggests that most time spent by `simplicial_set_embedding` is spent in a call to the `optimize_layout` method.
When profiling UMAP on bigger data sets though, another method emerges that also requires a significant amount of processing time.
As displayed in @fig:simplicial_tuna_googlenews_500k, for bigger data sets the method `spectral_layout` requires disproportionately more time than for small data sets.
Fortunately it is only used to initialize the low-dimensional representation in a special way.
This can also be done randomly, without having a severe impact on UMAP's visualization quality.

![Detailed times of the `simplicial_set_embedding` method on the GoogleNews data set.](figures/chapter3/simplicial_tuna_googlenews_500k.png){#fig:simplicial_tuna_googlenews_500k short-caption="Detailed times of the `simplicial_set_embedding` method on a GoogleNews data subset." width="100%"}

The `optimize_layout` method on the other hand, cannot simply be opted out of.
It is the essential part of the UMAP algorithm, that creates the low-dimensional representation.
Given a pre-initialized embedding, generated with or without `spectral_layout`, a stochastic gradient descent (SGD) procedure is performed.
Thereby the embedding is shaped to represent a graph created with help of the KNN search.

Each edge of the graph is iterated over and, with a chance based on the edge's weight, is sampled during the current iteration.
Each edge has two points in the embedding representing its nodes.
If the edge is sampled then the distance between these points is calculated.
Depending on whether this distance reflects the edge weight, the embedding points are moved closer or further apart.

Additionally negative sampling is done with the same probability for each edge.
For simpler implementability and better performance this always coincides with the times that the edge already gets sampled.
One of the two edge nodes is determined as the primary node by the way the edges are stored in memory.
Its point is used for negative sampling.
For it a certain number of other embedding points are randomly selected.
The distances between them and the point of the primary node are calculated.
Similar to normal sampling, the primary node's point is now moved according to these distances.

For the implementation of this SGD procedure conditional branching is required in multiple places.
Branching however negatively impacts the performance of GPUs.
GPUs operate on the principle of the SIMD model, where all threads perform the same sequences of commands in parallel, while processing different data points.
If the commands that are executed contain branching, threads no longer execute the same commands.
WhichThis requires the GPU to execute every branched off thread separately, as 
GPUs can only supply one command to each of th
 do  not let threads run different, leading the GPU t

, since it requires parallel threads to perform different tasks
 individual tasks.

Some 
This needs to be s
, the data accesses of this will 
, computing the distance to them and repositioning the embedding points

 is done by
 than each
So in 

data access reordering, only write to one y in one process to avoid write conflicts

actually write atomically

negative sampling

replace check $k==j$ with $ k = k + j % max-1$

init cuda 0.3776082992553711 seconds


[^pyprof]: https://docs.python.org/3/library/profile.html, accessed 25.04.2019
[^tuna_src]: https://pypi.org/project/tuna/, accessed 25.04.2019
[^repo_thesis]: https://github.com/p3732/master_thesis, accessed 29.04.2019

