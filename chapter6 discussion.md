# Discussion

## Advantages of GPUMAP
First and foremost, GPUMAP is noticeably faster than UMAP.
Considering that the profiling was done on older hardware, the difference for modern GPUs will be bigger, as GPUs underwent a bigger growth in performance than CPUs within the last years.
Recent GPU hardware has 10 times as many "CUDA cores".
While this does not guarantee linear speedup, there is as strong correlation.

For moderately-aged GPUs, GPUMAP also has the benefit of mostly running on the GPU and therefore not strongly competing for CPU resources.
This is an advantage e.g. if other computations are performed on the CPU and a results of running computations have to be visualized.

Further it can be argued by means of the estimations made in Table \ref{gpumap_tsne_big}, that GPUMAP does not perform significantly worse than other state of the art GPU-parallel visualization algorithms, at least for data sets of size and dimensionality similar to the compared data sets.

## Drawbacks of GPUMAP
GPUMAP unfortunately also has several drawbacks.
It does not support all features of the sequential version.
Apart from allowing to embed into already existing embeddings, GPUMAP neither supports sparse matrices nor user-defined distance metrics.

Further, the performance gains by the GPU parallelization are not drastic enough in its present state.
While both methods manually parallelized show good improvements, the usage of the FAISS library did not result in drastic improvements for big data sets.
Comparing the time spent for KNN search on the 500.000 data points GoogleNews data sub set, only shows a 16 seconds improvement, a mere 6% improvement over the sequential version.
For bigger data sets @fig:gpumap_plot_google_news indicates that performance could actually turn out to be worse than the sequential nearest-neighbors algorithm.
It could be that the relatively small speedup is caused by not using the FAISS library to its fullest, or that it performs is poorly because the available GPU memory is too small for an effective KNN search.

Finally, while the visualizations of big data sets with GPUMAP are noisy, they are still acceptable, as the data is positioned and spread out in the same way as with the UMAP algorithm.
The visualization of small data sets or such with fine structures as seen in @fig:umap_gpumap_viz_small are of too poor quality to use GPUMAP for visualization of small data sets.

