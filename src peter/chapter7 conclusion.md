# Conclusion

## Summary
The new implementation of UMAP for GPUs, named GPUMAP, is a fast dimensionality reduction algorithm.
It can compete with the currently fastest implementation of the status quo algorithm, t-SNE-CUDA.
While further improvements and features need to be added for GPUMAP to be a complete drop-in replacement for its sequential counterpart UMAP, it can already be used to create decent visualizations for big data sets in short time.
Installation instructions and usage examples can be found in the online repository of GPUMAP under [`https://github.com/p3732/gpumap`](https://github.com/p3732/gpumap).

## Future Works
Several improvements can still be made to GPUMAP.
Most importantly the visualization quality can be bettered, to more closely resemble that of UMAP.
For this, an improvement to the last algorithm subtask, the optimization of the embedding, is required.
Since the problem is presumed to stem from outdated values, a sequential processing of the last few iterations could be investigated.

Further, as observed in [Section 5.1](#performance), the library used to perform the KNN search does not perform as well for GPUMAP as for other projects.
While further optimization of how the library is used, could improve the performance, a more drastic solution would be to implement a GPU-parallel version of the algorithm used by UMAP, the NN-Descent algorithm [@nn-descent].
This would provide multiple advantages.
Firstly, NN-Descent has a better performance, as shown in the benchmarks of [@annbenchmark].
Secondly, a JIT-compiled implementation with Numba would allow supporting different distance metrics, bringing GPUMAP closer to feature parity with UMAP.
Finally, an implementation with Numba would make GPUMAP platform independent, since the currently used FAISS library is not available on the Windows platform.

An additional important feature currently missing from GPUMAP is support for sparse matrices.
Data sets that are big in size and dimensionality, but actually only contain comparatively few data points due to sparseness, are common when handling word vectors.
Supporting them would allow bigger, sparse, data sets to be visualized quickly.

\pagebreak

Apart from processing bigger data sets, another goal is to process small to medium-sized data sets swiftly.
If data sets can be visualized fast enough, they can be visually analyzed in close to real-time.
While GPUMAP already enables comparatively fast processing, the time spent on JIT-compilation is a constant factor.
If the CUDA functions were compiled "ahead of time" (AOT), data sets could be processed even faster.
Applications for this are numerable, from neural networks in machine learning, complex statistics in finance to DNA sequencing in biology.

## Closing Words
This thesis and the scripts with which the profilings and visualizations were produced, are available under [`https://github.com/p3732/master_thesis`](https://github.com/p3732/master_thesis).

