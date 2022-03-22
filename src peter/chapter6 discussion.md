# Discussion

## Advantages of GPUMAP
First and foremost, GPUMAP is noticeably faster than UMAP.
The achieved speedups of up to 20-60 times would not have been possible with CPUs, since even when assuming an ideal linear speedup, CPUs commonly do not have 20 units that can compute in parallel.
Considering the hardware development trend, the performance gap between GPUs and CPUs will keep growing, allowing for additional speedup of GPUMAP over CPU versions with upcoming hardware.

By mostly running on the GPU, GPUMAP also has the benefit of not competing for CPU resources.
This is an advantage e.g. if other computations are performed on the CPU and results of running computations have to be visualized.

Further it can be argued by means of the estimations made in Table \ref{gpumap_tsne}, that GPUMAP performs as good or better than other state of the art GPU-parallel visualization algorithms.
Especially when neglecting the time spent on JIT compilation, GPUMAP outperforms the t-SNE-CUDA implementation.

## Drawbacks of GPUMAP
GPUMAP unfortunately also has several drawbacks.
While it supports all features of the sequential version, not all are available as a GPU-parallel implementation.
Apart from allowing to embed into already existing embeddings, GPUMAP neither supports sparse matrices nor user-defined distance metrics.

Further, the performance gains by the GPU parallelization are not drastic enough in its present state.
While all subtasks that were implemented in parallel show good improvements, the usage of the FAISS library did not result in improvements as high as expected.
Other implementations, i.e. t-SNE-CUDA, also use the library with better results.
Most likely this is an implementation error, but since multiple versions have been tried out, including one equal to the t-SNE-CUDA implementation, it should also be considered to replace the library with another KNN search algorithm.

\pagebreak

Finally, the visualizations of GPUMAP contain a lot of "noise".
Raising the number of iterations in which the low-dimensional representation is getting adapted, partly solves this problem for big data sets.
However, the visualization of small data sets or such with fine structures as seen in @fig:umap_gpumap_viz_small are of too poor quality, to recommend using GPUMAP for visualizing such data sets.

The noise could be caused by outdated values, since the threads running in parallel on the GPU all work on the same data created in the previous iteration.
They don't see the updates that the other threads make until after the iteration.
This could cause points to be moved too far or too little, so that after the iteration some points that should have been moved closer together, end up getting moved past each other.
Or points that should have been moved slightly apart, end up getting distanced too far from each other.

