## Related Works {#relatedworks}
UMAP is of course not the first algorithm that has been ported to run on GPUs.
Multiple other algorithms have already been analyzed and adapted.
Since t-SNE is a highly related algorithm and shares some computational steps with UMAP it makes sense to evaluate efforts that followed an analogous approach.
Listed in the following are summarizations of two publications that both describe the adaption of the t-SNE algorithm for grapic cards.
For better understanding of some details on t-SNE it might prove useful to first consider the [section on t-SNE in chapter two](#tsne).

### Linear tSNE optimization for the Web
In this paper [@Pezzotti2018] Pezzotti et al. develop a variation of the t-SNE algorithm that can be run in the browser.
Their [code](https://github.com/tensorflow/tfjs-tsne) is based on the [TensorFlow.js library](https://github.com/tensorflow/tfjs) and available open source.
Thanks to WebGL and the open technology stack behind it, the implementation can still rely on using the graphics card, even though it runs in the browser.
An online [example](https://storage.googleapis.com/tfjs-examples/tsne-mnist-canvas/dist/index.html) exists.
It allows to visualize (parts of) the MNIST dataset [@mnist].
After the initialization phase every iteration step of the t-SNE algorithm is shown.


linearization of the algorithm
scales to large datasets

relies on modern graphics hardware

gradient 
objective function
scalar field that represents the point density and and the
directional repulsive forces in the embedding space.


Unfortunately the paper does not contain any measurement.
Neither execution times nor graphical results are provided.
Therefore a meaningful comparison with other implementations is unknown at the time of writing

pending

Thus a comparison to see the results in context





### t-SNE-CUDA
As indicated by its name, t-SNE-CUDA uses the Nvidia CUDA technology [@cuda] to parallelize the [t-SNE](#tsne) on GPUs. The t-SNE algorithm 
It hereby outperforms the CPU versions significantly. The paper lists a 50x speedup over the fastest parallel CPU version and a 650x speedup over the most commonly used version.

<!-- TODO BH has not been introduced yet-->
t-SNE-CUDA tries to decrease the number of necessary computations by parallelizing the approach described in the Barnes-Hut  by BH-TSNE.
Instead of considering relations between all data points, only a certain amount of nearest neighbors for each point are considered. This allows to represent the remaining data correlations in a sparse matrix, thus fundamentally using linear storage space.
For computations on these sparse matrices the cuBLAS Library [@cublas] is used, which offers a parallelized version of common BLAS operations.

 an operation optimized implementation.



