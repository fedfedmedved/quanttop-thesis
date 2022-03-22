## Aim of the Thesis {#aim}
In this thesis the UMAP algorithm is to be implemented in a parallel manner, so that it can be run on GPUs.
The parallel implementation will be derived from the original sequential algorithm.

<!--limit algorithm features-->
Due to the limitations that come with the form of a thesis, certain constraints are imposed.
While the original implementation of UMAP supports a wide range of distance metrics, the parallel implementation will exclusively focus on the Euclidean distance.
<!--most common-->
UMAP builds upon multiple components that carry out subtasks of the algorithm.
These subtasks will be solved by reusing existing implementations when possible.
For complex components without existing GPU implementations, such as Random Projection Trees, substitute algorithms will be used.
By these measures the development time is to be kept within a feasible time frame.

<!--CUDA-->
To implement the UMAP algorithm on GPUs the CUDA [@cuda] technology will be used.
It allows for parallel execution and memory management on GPUs.
This choice is made due to CUDA's widespread usage and its good performance, as can be seen in the previous [Section 1.2.2](#cudatsne).

<!--measurement-->
The developed algorithm will be evaluated.
For this the overall performance will be measured, as well as the performance of the algorithm's individual steps.
Paired with measurements of the original implementation, a comparison with the sequential version will show how much speedup is achieved by using the GPU.
Analyzing the algorithm's steps independently will provide insight as to which parts of the algorithm should be considered for future optimizations.

Furthermore, a comparison with the CUDA implementation of the t-SNE algorithm will be given.
It provides an estimation on the advantage of the implementation in practice.

