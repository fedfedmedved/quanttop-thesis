# Implementation {#implementation}
This chapter documents the implementation of GPU parallel UMAP (GPUMAP).
[Section 4.1](#technology) covers the technologies used and [section 4.2](#detailed_implementation) provides implementation details for the parallelized algorithm steps.

## Used Technologies {#technology}
To implement UMAP on GPUs, a library to communicate with the GPU is needed.
As already argued in [Section 1.3](#aim), the choice for this thesis is to use the CUDA library.
It provides good performance, a stable API and can be widely used since the supported Nvidia® GPUs are commonly available.

To avoid an implementation from scratch, the existing UMAP Python implementation is used as groundwork.
Building upon it, all subtasks that according to the analysis of [Chapter 3](#methods) benefit from parallelization, will be extended to support parallel execution on GPUs.
The CPU parts can still remain available and be used as a fallback if no GPU is available.

As mentioned in the previous chapter, UMAP uses Numba [@numba] to create compiled code during execution.
This allows for performant execution of computation-heavy code, without the need to rewrite it in compiled languages such as C.
The table in @fig:numba_comparison shows exemplary performance speedups when compared to standard Python code.
The JIT compilation of Numba is not limited to CPUs, it also supports "compiling a restricted subset of Python code into CUDA kernels" [^numba_cuda].
While not the complete API of CUDA is provided, all features required for this thesis are supported.
Thus, the methods described in the following sections are implemented in Python, which is JIT compiled by Numba and executed on GPUs.

![Speedups over normal Python interpreter for naive matrix multiplication of Numba JIT and compiled C Code via CPython. Taken from [@numba], Table 1.](figures/chapter4/numba_comparison.png){#fig:numba_comparison short-caption="Speedups of Numba compared to compiled C Code via CPython." width="40%"}

Another library used, is the `cupy` library [@cupy].
It provides functionality to move arrays from and to the GPU memory, as well as common operations that can be performed on arrays on the GPU, such as sorting and mean value calculation.
`cupy` can in many places be used as a drop-in replacement for the common `numpy` [^numpy] library.
Not only does this avoid copying from and to the GPU device, but also the operations are performed with GPU-acceleration.
<!--\pagebreak-->

## Implementation Details {#detailed_implementation}
Each proceeding section covers details on the implementations of one subtask for the GPU.
To be easier to follow, they are sorted in the order that they occur in the algorithm.
However, the first section describes what GPUMAP does if no GPU is available.

### Fallback Routines
To be able to execute on the GPU, the GPU parallel UMAP (GPUMAP) algorithm needs to assure that a supported GPU is available.
Numba provides an API to discover availability with `cuda.is_available()`.
It can be queried during execution, which allows to dynamically execute either a GPU or CPU implementation.
The following subtasks all use this method to allow running the CPU version as a fallback to the default GPU implementation.

For example the `nearest_neighbors` subtask of the upcoming section was modified to either call the new GPU implementation `nearest_neighbors_gpu` if a GPU is available, or the existing CPU implementation of UMAP, which was renamed to `nearest_neighbors_cpu`.

### Subtask `nearest_neighbors` {#nearest_neighbors}
The first step of the UMAP algorithm is a KNN search.
As the FAISS library is used to handle this subtask, the new implementation is mostly a wrapper function for communication with the library.
It first creates an index for the input data, on which a KNN search is to be performed, and then tasks FAISS to find the desired amount of nearest-neighbors for each data point using that index.

The chosen KNN search to be performed by FAISS is a brute-force method, since all other attempted variants performed worse.
This also holds for an implementation analogous to that of t-SNE-CUDA [@tsne-cuda].
As the non-brute-force algorithm relies on sampling, it could theoretically be made faster by using fewer samples, but this resulted in too low quality of the found nearest-neighbors, to be used further on in the algorithm.

FAISS offers a dedicated method for a brute-force KNN search, but it performed just as fast, while running out of memory sooner than the chosen version.
By default FAISS reserves 18% of the GPU memory for KNN search queries.
Since GPUMAP needs to retrieve all neighbors for all nodes, the whole query set will not fit into the 18% reserved memory, if the data set is bigger than the reserved memory.
Therefore querying  of too big data sets is done in five iterations, so that no additional memory needs to be allocated, hereby saving time.

Since FAISS only supports the use of an Euclidean metric, a check is performed that it also is the user-defined metric. Otherwise the CPU version is used.
Further, FAISS does not support searching for more than 1024 nearest-neighbors, which therefore also causes a fallback to the CPU version.

### Subtask `fuzzy_simplicial_set`
Most time spent by the `fuzzy_simplicial_set` subtask is used on a call to `smooth_knn_dist`, which iterates over the distances calculated by the previous algorithm subtask, `nearest_neighbors`.
It "smooths" the distances between nearest-neighbors, by normalizing each set of edges related to one node.
The normalization is based on the node's local connectivity and done independently for each set of distances, making the method "embarrassingly parallel".
As a result, no memory access restrictions need to be managed.

For parallelization each thread is assigned a block of consecutive sets of distances.
Each set contains the distances between one node and its KNN.
By iterating over these sets, two steps are performed.
First a distance with which to normalize is determined.
That distance is then used in a binary search to normalize all values.

The original CPU code of the `smooth_knn_dist` contained a comment, that the code is "very inefficient"[^umap_code_comment].
Indeed the code does contain several redundant recalculations of mean values and passes each distances set multiple times.
The GPU code fixes this by calculating the mean over all values once, and calculating all other required values during a single pass of each distance set.

Further parallelization of `fuzzy_simplicial_set` was done for the `compute_membership` `_strengths` subtask, which is equally embarrassingly parallel and straightforward to implement.
Additionally some array manipulations were performed on the GPU by using `cupy`.

### Subtask `simplicial_set_embedding` {#detail_simplicial_set_embedding}
The most time of the `simplicial_set_embedding` subtask is spent on a call to the `optimize_layout` subtask.
Due to its complexity it is split out into its own [section]{#detail_optimize_layout}.
This section covers the remaining parts.

`simplicial_set_embedding` receives the normalized KNN distances from the `fuzzy_simplicial_set` subtask.
It removes duplicates and values that are too small from them.
This is implemented by using the `cupy` library.

Afterwards it initializes the low-dimensional embedding.
For inputs with less than 100.000 data points the CPU implementation of `spectral_layout` is used.
For bigger inputs a random initialization is done in parallel on the GPU.

One last step is to calculate the probabilities with which to sample in the upcoming `optimize_layout` subtask.
This is handled by the `make_epochs_per_sample` subtask, which is GPU-parallelized by using cupy.
Then the `optimize_layout` subtask is called.
All data is already allocated on the GPU, so that no additional GPU-CPU data transfers are needed.

### Subtask `optimize_layout` {#detail_optimize_layout}
`optimize_layout` is the implementation of the Stochastic Gradient Descent procedure.
It consists of several nested loops, in which positive sampling and negative sampling are done.
The most outer loop iterates over the number of epochs of the SGD.
Parallelizing this loop is not possible, as each epoch builds on the processed embedding data of the previous one.

The loop nested one layer deeper iterates over all edges.
It can be used for parallelization, albeit not as directly as e.g. `smooth_knn_dist`, since each edge links two separate data points.
When an edge is sampled both of these points are repositioned in SGD.
Since the graph is connected, each node is part of more than one edge and parsing both nodes of the edges therefore causes data access conflicts.

A solution to avoid these conflicts is to duplicate all edges, assign the associated nodes to the duplicated edge in reversed order, and then sort all edges by their first node.
As it happens to be, this is already the case due to the way the KNN search builds the graph.
If each edge is only sampled for its first node, and one thread is responsible for all edges where this node is the first node, then the changes to this node can be written without any data write conflicts.

When processing each edge split into its two nodes, another problem occurs.
Since the nodes of the edge are processed independently, they can also read varying values due to desynchronization.
While one node of an edge could be processed at the beginning of an epoch, the other could be processed at the end.
The nodes will be repositioned independently of each other, which also means that the weight of the edge connecting the nodes, could be badly represented after the epoch ends.
This is caused by a less obvious read-write conflict that arises due to the data being processed in-memory.
@fig:mnist_no_other shows an example for an embedding produced with this error.
Memory caches amplify the problem by providing values that are outdated, but not invalidated.

<div id="fig:flawed_mnists" class="subfigures">
![Expected visualization of MNIST, given for comparison.](figures/chapter4/mnist_correct.png){#fig:mnist_correct width="45%"}
\hfill
![Caused by data inconsistency when processing nodes of edges separately.](figures/chapter4/mnist_no_other.png){#fig:mnist_no_other width="45%"}

![Caused by thread desynchronization.](figures/chapter4/mnist_hole.png){width=45% #fig:mnist_hole}
\hfill
![Caused by using collective random values for blocks of threads.](figures/chapter4/mnist_collective_randoms.png){width=45% 
#fig:mnist_collective_randoms}

Flawed visualizations of the MNIST data set.
</div>

The problem can be resolved by using two embedding data arrays.
All read operations are performed on one embedding, while the changes are written to the other.
When all threads are done processing the edges assigned to them, the data sets are swapped and the procedure is repeated.

While this approach may work in theory, a practical problem is the mapping of nodes to threads.
If the assigning is done statically, then the number of edges that one thread is in charge of, can vary widely.
Balancing the computation load equally on all threads requires a sophisticated algorithm.
Since a parallel algorithm would need to consider a multitude of variables, this should be done in a sequential algorithm, which would add extra time required for copying from and to the GPU.

The way the GPUMAP implementation resolves this problem, is by not assigning nodes to threads.
Instead the algorithm as described is performed, but the edges are statically assigned to each thread.
Since only the first and the last node that a thread is responsible for, could potentially be processed by another thread, these cases are treated separately.
To not overwrite potential changes by the other thread that could write to this node, each write access is done by averaging the previous and the new value.
This way the loss of information is reduced and write conflicts can be mitigated.

With the core implementation in place, further optimizations can be tried out.

A successful optimization of the algorithm is the use of global variables.
These are seen as constants by the Numba JIT compiler, allowing for constant folding and loop unrolling.
A specialized implementation originally fine-tuned for the embedding into two dimensions was thus made redundant, as it now performed slower than the optimized generic version.

A less successful attempt to improve performance was by optimizing memory access.
Since accessing any data in memory usually causes the hardware to load not just the desired data values, but the whole memory bank in which it resides, random accesses to memory are very inefficient and lead to many cache misses.
The random accesses caused by negative sampling are thus very inefficient, as only a small part of the cached memory is actually used.
If a group of threads with a shared cache were to use successive nodes for negative sampling, the caching efficiency and therefore memory efficiency could increase.
The downside to this approach however, is the loss of entropy.
As the result of the implementation in @fig:mnist_collective_randoms shows, the visualization quality deteriorates significantly, rendering this optimization impractical.

Another successful optimization was already covered in [Section 3.2.3](#methods_optimize_layout).
By using a pre-filtering method, branching of the GPU threads can be avoided.
During the implementation it brought a big performance gain, halving the previous time spent on `optimize_layout`.
However, avoidance of branching is not just important for performance.
The way the random number selection for negative sampling was originally done, caused the parallel version to look like shown in @fig:mnist_hole.
 
As expected, a random number is created.
It is used to randomly access a data point of the embedding.
To assure that no node of the current edge is selected, a simple `if` construct is used, that branches off and continues with the remaining loop iterations of the negative sampling.
The hole that can be observed circles the zero point, so the reason could potentially be that all points were negatively sampled with zero and thus were pushed away from it.

\begin{equation}
k = \texttt{rand()} \% (N-1) + i + 1
\end{equation}
\label{eq:random_number}

Replacing the branching with a modified version of the random number generation based on Equation 4.1, avoids this strange side effect.
The formula can be used to receive a random point $k$ out of $N$ points, while guaranteeing that the value $i$ will never be chosen for $k$.
The formula can be nested to avoid multiple points.
This way both nodes of an edge can be avoided during negative sampling.

[^numba_cuda]: from http://numba.pydata.org/numba-doc/latest/cuda/overview.html, accessed 28.04.2019
[^numpy]: https://docs.scipy.org/doc/numpy/, accessed 20.05.2019
[^umap_code_comment]: https://github.com/lmcinnes/umap/blob/a858c6322a3e682d8daf9c17e13ac023f3e18cfa/ umap/umap_.py#L96, accessed 28.04.2019
