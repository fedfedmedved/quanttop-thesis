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
Their code [^pezzoti_code] is based on the TensorFlow.js library [^tensorflow_code] and available under the Apache free software license.
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

<!--TODO revisit after BH-TSNE is written-->
However, t-SNE in its normal form can not efficiently be written as a shader, since it uses a tree data structure.
Trees don't store the data they contain in a consecutive manner, but instead nested on different branches.
Conditions need to be evaluated in order to know under which branch the desired data is stored.
Accessing data in parallel can therefore only be done if the processing units can execute code independent of each other.
GPUs are not capable of such branched executions, since all computing units need to follow the same instructions in a SIMD manner (Single Instruction, Multiple Data).

Therefore Pezzotti et al. construct a variation of the t-SNE algorithm.
Details on how this was achieved can be found in the publication [@Pezzotti2018].
In summarization the algorithm's modified version replaces the tree data structure with a vector and a scalar field.
Both are represented by respective two dimensional textures and can be accessed in parallel.
By sampling these textures through a shader, parallel execution of the algorithm is accomplished.

This t-SNE variant has linear computational complexity since the aforementioned sampling is only done linearly often, in accordance to the input problem's size.
The linearization allows for better scaling of the algorithm, by using less main memory.
But the sampling of the vector and scalar fields also leads to inaccuracies, since it approximates the values of the original t-SNE algorithm.
Albeit the paper argues that the introduced errors are neglectable, it unfortunately does not provide any results to support this.
Neither execution times of the algorithm, nor graphical results are provided.
Therefore a meaningful comparison with other implementations can not be made at the time of writing.

<!--t-SNE uses a gradient of its objective function to iterate closer to a final result.-->
<!--Pezzotti et al. rewrite this gradient, by splitting it up into two factors.-->
<!--The attractive forces, which move data points closer to each other and the repulsive forces, that respectively do the opposite.-->
<!--Both are then shown to be computable in a linear way.-->

<!--For calculating the attractive forces, only a fixed amount of nearest-neighbors are considered.-->
<!--This is justified, since only those have a significant influence on the attraction.-->
<!--The current density distribution of transformed data points is used to normalize the attractive forces.-->
<!--It is calculated by sampling on a scalar field a linear amount of times.-->
<!--The repulsive forces are computed using a similarly sampled vector field.-->

<!--Both fields are implemented with textures.-->
<!--These are manipulated through the rest of the code, which is wrapped in a shader.-->
<!--Thus the variant manages to have linear computational complexity and running on the graphics card.-->
<!--Additionally the linearization allows for better scaling of the algorithm, by using less main memory.-->

An online example[^pezzoti_online] using the algorithm exists.
It allows to visualize parts of the MNIST dataset [@mnist].
After the initialization phase every iteration step of the t-SNE algorithm can be seen.
It provides a simple user interface to configure perplexity, the amount of k-nearest neighbor iterations and the amount of t-SNE iterations.
@fig:tfjs-tsne shows the outcome when the example is run with the default settings.


![Graphical outcome of the online example of Pezzotti et al.'s t-SNE variation.
  The used parameters were a perplexity of 30, 800 kNN iterations and 500 iterations.
  Visualized is a subset of the MNIST data set, consisting of 10.000 digits.
](figures/chapter1/pezzoti.png){#fig:tfjs-tsne short-caption="Visualization of an MNIST subset by Pezzotti et al.'s t-SNE variation" width="40%"}

By measuring the GPU workload, an approximation on the running time was made.
On a system with an Intel® Core™ i5-6200U CPU, which includes an Intel® HD Graphics 520 graphics card, an execution of the algorithm took about 55 seconds.
The first part of the kNN iterations part took approximately 20 seconds.
The GPU usage was at 100 percent throughout this part.
The second part consisting of the t-SNE iterations took an estimated 35 seconds, with an average GPU usage of about 50 percent.

When assuming that this performance can be linearly scaled to the complete MNIST data set, then this would outperform CPU implementations, which range between 500 and 4500 seconds according to [@tsne-cuda].
It should be noted that the online example also provides visual feedback on the embedding for each step.
These visual updates cause computational overhead, through interrupts.
They explain the lowered average GPU usage in the second part.

Overall this publication has good approaches.
The usage of web technology makes the implementation platform independent and convenient to use.
But when compared with other technologies, such as the upcoming t-SNE-CUDA implementation, WebGL and shaders don't seem to be the best choice to maximize the computation speed.

### t-SNE-CUDA: GPU-Accelerated t-SNE and its Applications to Modern Data
As indicated by its name, t-SNE-CUDA by Chan et al.[@tsne-cuda] uses the Nvidia CUDA technology [@cuda] to port the [t-SNE](#tsne) algorithm to GPUs.
The code is available at the projects Github repository[^repo_tsne_cuda] under the BSD free software license.
Provided results show that it outperforms all available CPU versions of t-SNE significantly.
The paper lists a 50 times speedup over the fastest parallel CPU version and a 650 times speedup over a commonly used version.

t-SNE uses a Barnes-Hut tree to reduce the number of necessary computations between data points.
In a similar manner t-SNE-CUDA only considers relations between a certain amount of nearest-neighbors for each point.
These neighbors are calculated using the approximate k-nearest-neighbors algorithm provided by the FAISS library [@faiss].
The library's algorithm too runs on the graphics card and shows to be outperforming other nearest-neighbor search implementations.

By using a sparse representation, relations that are negligible do not need to be represented.
This results in a requirement of linear storage.
For computations on these sparse representations the cuBLAS Library [@cublas] is used.
cuBLAS offers parallelized versions of common BLAS (Basic Linear Algebra Subprograms) operations, such as matrix-vector multiplication, matrix summation or matrix-matrix multiplication.

From the found neighborhoods a Barnes-Hut tree is constructed.
The construction of the tree is adapted from an implementation [@Burtscher2011] of Barnes-Hut trees in CUDA.
This part of the algorithm is very analogous to the original algorithm.
All operations are either on the tree or the sparse representations and are executed in parallel on the graphics card.

t-SNE-CUDA can profit from building upon multiple existing implementations.
Since they are already shown to be fast it is safe to reuse them for good performance.
The results prove this to be advantageous.
Not not only are the aforementioned speedups compared to CPU versions high, but the graphical results look visually pleasing too.

### Comparison of TensorFlow t-SNE and t-SNE-CUDA
The previously listed works use two very different approaches.
They diverge on many aspects, as the rundown in the following table shows.


| Implementation   | Technology | Frontend      | Performance (embedding of MNIST)|
| -----------------|------------|---------------|---------------------------------|
| TensorFlow t-SNE | WebGL      | Browser / GUI | 330 seconds (approximation)     |
| t-SNE-CUDA       | CUDA       | Python / CLI  | 7 seconds                       |


With all this considered, this thesis will strike to rather follow the paths of the latter work.
The next section on aims of the thesis tries to capture that.

[^pezzoti_code]: https://github.com/tensorflow/tfjs-tsne, last accessed 20.04.2019
[^tensorflow_code]: https://github.com/tensorflow/tfjs, last accessed 20.04.2019
[^pezzoti_online]: https://storage.googleapis.com/tfjs-examples/tsne-mnist-canvas/dist/index.html, last accessed 20.04.2019
[^repo_tsne_cuda]: https://github.com/CannyLab/tsne-cuda, last accessed 20.04.2019
