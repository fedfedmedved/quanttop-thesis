# Conclusion
<!--Concluding this thesis an outlook on possible future works is given, followed by final remarks.-->

## Future Works
The fact that the sequential KNN CPU algorithm performs as good as the KNN algorithm of the GPU optimized library, indicates that there is room for improvement in this area.
Potential options are a GPU implementation of the NN-descent algorithm [@nn-descent], which also is used by the sequential UMAP algorithm.
When done with the CUDA Numba interface, it potentially allows for the use of distance metrics other than the Euclidean metric.
This would bring GPUMAP closer to function parity with the CPU implementation.

An additional important feature currently not supported by GPUMAP is sparse matrices.
Data sets that are big in size and dimensionality, but actually only contain comparatively few data points due to sparseness, are common when handling word vectors.
Supporting them would allow even bigger, sparse, data sets to be visualized quickly.
For non-sparse data sets, support of batch processing data sets would be required.  

While enabling parsing of bigger data sets is useful, a more interesting goal to persue is responsive visualization of small to medium-sized data sets.
If such data sets can be visualized swiftly enough, they can be visually analyzed in close to real-time.
Applications for this are numerable, from neural networks in machine learning, complex statistics in finance to DNA sequencing in biology.

The time taken for a visualization would need to be lowered to a point, where it is tolerable for humans to await graphic output as direct feedback.
To achieve this with GPUMAP, the performance needs to be further improved.
Apart from the above mentioned KNN algorithm improvements, support for multiple GPUs could be explored.
Further, memory copies between GPU and CPU should be reduced, requiring the remaining parts of the algorithm to be parallelized for GPUs as well.

## Closing Words
With GPUMAP a fast dimensionality reduction that runs on GPUs is available.
Installation instructions and usage examples can be found in the online repository of GPUMAP under [`https://github.com/p3732/gpumap`](https://github.com/p3732/gpumap).
While further improvements need to be made for it being a drop-in replacment for UMAP, it can already be used to create visualization for big data set cmparatively fast.



