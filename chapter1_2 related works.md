## Related Works {#relatedworks}
Multiple algorithms have already been analyzed and adapted, in order to run on GPUs.
So for porting UMAP an analysis of similar algorithms' ports is useful.
t-SNE is a highly related algorithm, that also shares computational steps with UMAP.
Since there already are ports of t-SNE for graphics cards, the following sections evaluate these efforts.
Listed are summarizations of two publications and explanations of their approaches.
A detailed description of t-SNE is given in its dedicated [section in chapter two](#tsne).
For the following sections detailed knowledge of the algorithm is not necessary.

### Linear tSNE Optimization for the Web
In [@Pezzotti2018] Pezzotti et al. develop a variation of the t-SNE algorithm that can be run in the browser.
Their [code](https://github.com/tensorflow/tfjs-tsne) is based on the [TensorFlow.js library](https://github.com/tensorflow/tfjs) and available under the Apache free software license.
Instead of directly porting the algorithm to run in the browser via Javascript, the publication describes how to modify t-SNE in a way that it can be run on graphics cards.

Modern browsers are sandboxed, meaning that they prevent any executed code from directly accessing the hardware.
The only way scripts can communicate with other parts of the system is through designated APIs.
WebGL [@webgl] provides such an API, with which images can be rendered on the graphics card from within the browser.
These images are computed by shaders, programs that contain instructions on how to generate the graphical output.
The shader code is not limited in computation complexity.
Merely the input data is limited by a maximum size of textures that the graphics card can hold in its main memory.

Traditionally WebGL is used to render graphics.
But if an algorithm can be rewritten to a form where it's instructions are written as a shader and its input data can be encoded in a texture, then that way the algorithm can be deployed to the graphics card by using WebGL.
Pezzotti et al. used this to run t-SNE on GPUs from within a browser.

However, t-SNE in its normal form can not efficiently be written as a shader.
It uses a tree data structure which is difficult to represent as a texture.
Even if it were, then this texture can not be accessed by the shader code in parallel.
Accessing trees requires evaluation of conditional values and executing different parts of the code, depending on the result of the condition.
GPUs are not capable of such branched executions, since all computing units need to follow the same instructions.

Therefore the paper constructs a variation of the t-SNE algorithm.
Instead of using a tree data structure, 
<!--TODO-->
<!--TODO-->
<!--TODO-->
t-SNE uses a gradient of its objective function to iterate closer to a final result.
Pezzotti et al. rewrite this gradient, by splitting it up into two factors.
The attractive forces, which move data points closer to each other and the repulsive forces, that respectively do the opposite.
Both are then shown to be computable in a linear way.
<!--TODO more details? less?-->

For calculating the attractive forces, only a fixed amount of nearest-neighbors are considered.
This is justified, since only those have a significant influence on the attraction.
The current density distribution of transformed data points is used to normalize the attractive forces.
It is calculated by sampling on a scalar field a linear amount of times.
The repulsive forces are computed using a similarly sampled vector field.

Both fields are implemented with textures.
These are manipulated through the rest of the code, which is wrapped in a shader.
Thus so the variant manages to have linear computational complexity and running on the graphics card.
Additionally the linearization allows for better scaling of the algorithm, by using less main memory.

Nonetheless it should be mentioned that the linearization also introduces some inaccuracies into the algorithm.
The approximations made by sampling the vector and scalar fields lead to computational errors.
Albeit the paper argues that the introduced errors are neglectable, it unfortunately does not provide any results to support this.
Neither execution times of the algorithm, nor graphical results are provided.
Therefore a meaningful comparison with other implementations can not be made at the time of writing.

An online [example](https://storage.googleapis.com/tfjs-examples/tsne-mnist-canvas/dist/index.html) using the algorithm exists though.
It allows to visualize (parts of) the MNIST dataset [@mnist].
After the initialization phase every iteration step of the t-SNE algorithm can be seen.
Although the interface presentation and the interactivity are very nice, the performance of this demo seems not to be overwhelmingly fast.
During several simple tests on average consumer hardware it consistently took more than a minute to visualize a subset of just 500 digits.

Overall this paper has good approaches, but it does not leave the impression that WebGL and shaders are the best choice when it comes to fast parallel computing on graphics cards.

### t-SNE-CUDA: GPU-Accelerated t-SNE and its Applications to Modern Data
As indicated by its name, t-SNE-CUDA by Chan et al.[@Chan2018] uses the Nvidia CUDA technology [@cuda] to port the [t-SNE](#tsne) algorithm to GPUs.
The code is available at the projects [Github repository](https://github.com/CannyLab/tsne-cuda) under the BSD free software license.
Provided results show that it outperforms all available CPU versions of t-SNE significantly.
The paper lists a 50x speedup over the fastest parallel CPU version and a 650x speedup over a commonly used version.

t-SNE uses a Barnes-Hut tree to reduce the number of necessary computations between data points.
In a similar manner t-SNE-CUDA only considers relations between a certain amount of nearest-neighbors for each point.
These neighbors are calculated using the approximate k-nearest-neighbors algorithm provided by the FAISS library [@faiss].
The library's algorithm too runs on the graphics card and shows to be outperforming other such nearest-neighbor search implementations.

By using a sparse matrix, relations that are not needed do not need to be represented.
This fundamentally uses linear storage space.
For computations on these sparse matrices the cuBLAS Library [@cublas] is used.
cuBLAS offers parallelized versions of common BLAS operations, such as matrix vector multiplication, matrix summation or matrix-matrix multiplication.

The found neighborhoods are used to calculate the $P_{ij}$ matrix.
From it a Barnes-Hut tree is constructed.
The tree in turn is used to calculate the gradient of t-SNE's objective function.
This part of the algorithm is very analogous to the original algorithm.
All operations are either on the tree or on sparse matrices.

The construction of the tree is adapted from an implementation [@Burtscher2011] of Barnes-Hut trees in CUDA.
t-SNE-CUDA can profit from building upon all of these existing implementations.
Since they are already shown to be fast it is safe to reuse them for good performance.
The results prove this approach to work.
Not not only are the aforementioned speedups compared to CPU versions high, but the graphical results look good too.

This thesis will try to follow some paths of this work.
The next section on aims of the thesis tries to capture that.



### Comparison of TensorFlow t-SNE and t-SNE-CUDA
The previously listed works use two very different .
They diverge on many aspects, as the rundown in the following table shows.

| Implementation   | Technology | Frontend      | Performance                      |
| -----------------|------------|---------------|----------------------------------|
| TensorFlow t-SNE | WebGL      | Browser / GUI | Good                             |
| t-SNE-CUDA       | CUDA       | Python / CLI  | Lacking results (Presumably bad) |

With all this considered, this thesis will strike to rather follow an approach
