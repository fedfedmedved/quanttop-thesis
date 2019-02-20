## Aim of the Thesis
In this thesis the UMAP algorithm is to be implemented in a parallel manner, so that it can be run on graphics cards.
The parallel implementation will be derived from the original sequential algorithm and follow it as closely as achievable.

<!--limit algorithm features-->
UMAP builds upon multiple components that carry out subtasks of the algorithm.
To keep development time within a feasible time frame, these subtasks will be solved by reusing existing implementations where possible.
For complex components without existing GPU implementations, such as Random Projection trees, substitute algorithms will be used.
Even if the substitutes may not be on par with the original components, the performance gain through using GPUs should still outweigh potential theoretical performance losses.

While the original implementation of UMAP supports a wide range of distance metrics, the parallel implementation will exclusively focus on the Euclidean distance.
The reasoning is the same of limited development time.

<!--CUDA-->
To implement the UMAP algorithm on graphics cards the CUDA [@cuda] technology will be used.
It allows for parallel execution on GPUs and managing the memory on the graphics card.
This choice is made due to CUDA's widespread usage, its good performance, as well as previous experience in it.

<!--measurement-->
A measurement of the implementation will provide results on its performance.
To put these results into perspective, a comparison with the sequential version will show how much speedup was achieved by using the GPU.
A comparison with the CUDA implementation of the t-SNE algorithm will give an estimation on the advantage of the implementation in practice.

Furthermore the performance of the coarse-grained algorithm steps will be analyzed independently.
This gives an insight to which parts should be considered for future optimization attempts.
