## Related Works {#relatedworks}
Multiple algorithms have already been analyzed and adapted, in order to run on GPUs.
Thus, for porting UMAP an analysis of similar algorithms' ports is useful.
Analyzing their approaches will provide inspiration on technology that can be used and estimations of what speedups can be achieved.
t-SNE is a highly related algorithm, that also shares computational steps with UMAP.
Since there are ports of t-SNE for GPUs, the following section evaluates these efforts.
Listed are summarizations of two publications and explanations of their approaches.
A detailed description of t-SNE is given in [section 2.2.2](#tsne).

### Linear tSNE Optimization for the Web
In [@Pezzotti2018] Pezzotti et al. develop a variation of the t-SNE algorithm that can be run in the browser.
Their code [^pezzoti_code] is based on the TensorFlow.js library [^tensorflow_code] and available under the Apache free software license.
Instead of directly porting the algorithm to run in the browser via Javascript, the publication describes how to modify t-SNE in a way that it can be run on GPUs.
This way the advantage of the web's platform independence can be combined with the fast performance of GPUs.

Modern browsers are sandboxed, meaning that they prevent any executed code from directly accessing the hardware.
The only way scripts can communicate with other parts of the system is through designated APIs.
WebGL [@webgl] provides such an API, with which images can be rendered on the GPU from within the browser.
These images are computed by shaders, programs that contain instructions on how to generate the graphical output.
The shader code is not limited in computation complexity.
Merely the input data is limited by a maximum size of textures that the GPU can hold in its main memory.

Traditionally WebGL is used for rendering.
But if an algorithm can be rewritten to a form where its instructions are written as a shader and its input data can be encoded in a texture, then the algorithm can be deployed to the GPU by using WebGL.
Pezzotti et al. used this to run t-SNE on GPUs from within a browser.

However, t-SNE in its normal form can not efficiently be written as a shader, since it uses a tree data structure.
Trees do not store the data they contain in a consecutive manner, but instead nested on different branches.
Conditions need to be evaluated in order to know under which branch the desired data is stored.
Accessing data in parallel can therefore only be done if the processing units can execute code independent of each other.
GPUs are not capable of such branched executions, since all computing units need to follow the same instructions in a SIMD manner (Single Instruction, Multiple Data).

Hence Pezzotti et al. construct a variation of the t-SNE algorithm.
Details on how this was achieved can be found in the publication [@Pezzotti2018].
In summarization the algorithm's modified version replaces t-SNE's tree data structure with two dimensional fields.
These are represented by respective two dimensional textures and can be accessed in parallel.
By sampling the textures through a shader, parallel execution of the algorithm is accomplished.

This variant of t-SNE has a time complexity of $\mathcal{O}(N)$, since the computational complexity of the sampling is linear.
The linearization allows for better scaling of the algorithm, by using less main memory.
But the sampling also leads to inaccuracies, since it approximates the values of the original t-SNE algorithm.
Albeit the publication argues that the introduced errors are negligible, it unfortunately does not provide any results to support this.
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
<!--Thus the variant manages to have linear computational complexity and running on the GPU.-->
<!--Additionally the linearization allows for better scaling of the algorithm, by using less main memory.-->

An online example[^pezzoti_online] using the algorithm exists.
It allows to visualize parts of the MNIST dataset [@mnist].
After the initialization phase every iteration step of the t-SNE algorithm can be seen.
It provides a simple user interface to configure perplexity and the amount of iterations.
@fig:tfjs-tsne shows the outcome when the example is run with the default settings.

<!-- TODO what iterations KNN -->
![Graphical outcome of the online example of Pezzotti et al.'s t-SNE variation.
  The used parameters were a perplexity of 30, 800 KNN iterations and 500 t-SNE iterations.
  Visualized is a subset of the MNIST data set, consisting of 10.000 digits.
](figures/chapter1/pezzoti.png){#fig:tfjs-tsne short-caption="Visualization of an MNIST subset by Pezzotti et al.'s t-SNE variation." width="50%"}

By measuring the GPU workload, an approximation on the running time was made.
On a system with an Intel® Core™ i5-6200U CPU, which includes an Intel® HD Graphics 520 GPU, an execution of the algorithm took about 55 seconds.
The first part, in which the nearest neighbors for each data point are computed, took approximately 20 seconds.
The GPU usage was at 100 percent throughout this part.
The second part, consisting of the embedding optimization iterations, took about 35 seconds, with an average GPU usage of 50 percent.

When assuming that this performance can be linearly scaled to the complete MNIST data set, then this would outperform CPU implementations, which range between 500 and 4500 seconds according to [@tsne-cuda].
It should be noted that the online example also provides visual feedback on the embedding for each step.
These visual updates cause computational overhead, through interrupts.
They explain the lowered average GPU usage in the second part.

Overall this publication has good approaches.
The usage of web technology makes the implementation platform independent and convenient to use.
But when compared with other technologies, such as the upcoming t-SNE-CUDA implementation, WebGL and shaders do not seem to be the best choice to maximize the computation speed.

### t-SNE-CUDA: GPU-Accelerated t-SNE and its Applications to Modern Data {#cudatsne}
As indicated by its name, t-SNE-CUDA by Chan et al. [@tsne-cuda] uses the Nvidia CUDA technology [@cuda] to port the [t-SNE](#tsne) algorithm to GPUs.
The code is available at the projects Github repository[^repo_tsne_cuda] and is licensed under the BSD free software license.
Provided results show that it outperforms all available CPU versions of t-SNE significantly.
The publication claims a 50 times speedup over the fastest parallel CPU version and a 650 times speedup over a commonly used version.

The t-SNE algorithm consists of two parts.
First, a K-Nearest-Neighbor (KNN) search is performed.
From it a sparse representation of similarities between data points are created, based upon which data points are close to one another.
In the second part a low-dimensional representation of the original data is formed.
By measuring the similarities of the low-dimensional representation and comparing it to the similarities of the original input data, the low-dimensional representation is iteratively altered to represent the original data as accurately as possible.

<!--KNN-->
While the original t-SNE algorithm uses a tree data structure to perform a KNN search, CUDA-t-SNE uses the index-based approximate KNN algorithm provided by the FAISS library [@faiss].
The library's algorithm runs on the GPU and outperforms other KNN search implementations.

<!--sparse representation-->
From the KNN search constructed data point similarities are stored in a sparse representation.
Most similarities are neglected, as they have too little impact on the outcome of the algorithm.
Only a certain amount of nearest-neighbors are considered for each point.
In consequence the similarities can be stored in a sparse representation, resulting in a linear storage requirement.
For computations on these sparse representations CUDA-t-SNE uses the cuBLAS Library [@cublas].
cuBLAS offers parallelized versions of common BLAS (Basic Linear Algebra Subprograms) operations, such as basic matrix and vector calculations.

<!--barnes hut-->
In the iterative second part of the algorithm, t-SNE uses the Barnes-Hut algorithm [@Barnes1986] to reduce the number of necessary computations between data points.
In each iteration a quadtree of the current embedding is constructed.
The tree allows to summarize distance calculations from one point to a group of other points, if the group is close together and has a high distance from the point.
The construction of the tree is adapted from an implementation of the Barnes-Hut algorithm in CUDA [@Burtscher2011].
Overall this part of the algorithm is analogous to the original algorithm.
All operations are either on the tree or the sparse representations and are executed in parallel on the GPU.

t-SNE-CUDA can profit from building upon existing programs and libraries.
Not only does this safe development time and resources, but also the existing implementations have already been tested and optimized.
Thus t-SNE-CUDA can benefit from their performance, which can be seen in the results.
The speedups compared to CPU versions are high and the graphical results are indistinguishable from those of the original sequential algorithm.

### Comparison of TensorFlow t-SNE and t-SNE-CUDA
The previously listed works use two very different approaches on how to use GPUs to parallelize t-SNE.
They diverge on many aspects, as the rundown in the following table shows.
Additionally two variants of t-SNE are added for comparison.
One is part of the popular scikit-learn library [scikit-learning_rate].
It is a Python implementation that only supports sequential execution.
Multicore t-SNE on the other hand is a parallel implementation, that can run on multiple CPU cores.
The results listed in the table were achieved by using 4 CPU cores in parallel.
The performance column consists of times that the algorithm took to embed the full MNIST data set.

|Implementation|Technology|Frontend|Performance|
|---------------------|--------------|---------------|--------------------------|
| scikit-learn t-SNE [^scikit_src]|Python| Python / CLI  | 4556 seconds, see [@tsne-cuda]|
| Multicore t-SNE [@Ulyanov2016]  |C++, Python| Python / CLI  | 501 seconds, see [@tsne-cuda]|
| TensorFlow t-SNE |WebGL  |Browser / GUI| 300 seconds (estimation)|
| t-SNE-CUDA       |CUDA|Python / CLI| 7 seconds, see [@tsne-cuda]|

<!--TODO fix no new row multicore-->

All things considered, this thesis will strive to follow the paths of the t-SNE-CUDA work.
The next section on the aims of the thesis tries to capture this.

[^pezzoti_code]: https://github.com/tensorflow/tfjs-tsne, last accessed 20.04.2019
[^tensorflow_code]: https://github.com/tensorflow/tfjs, last accessed 20.04.2019
[^pezzoti_online]: https://storage.googleapis.com/tfjs-examples/tsne-mnist-canvas/dist/index.html, last accessed 20.04.2019
[^repo_tsne_cuda]: https://github.com/CannyLab/tsne-cuda, last accessed 20.04.2019
[^scikit_src]: https://scikit-learn.org/stable/modules/generated/sklearn.manifold.TSNE.html, last accessed 20.04.2019

