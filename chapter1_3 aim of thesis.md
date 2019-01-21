## Aim of the Thesis
In this thesis the UMAP algorithm is to be implemented in a parallel manner, so that it can be run on graphics cards.
The CUDA [@cuda] technology will be used to achieve parallel execution on GPUs.
A choice made due to its widespread usage and its performance, as well as previous experience in it.
While the original implementation of UMAP supports a wide range of distance metrics, our implementation will exclusively focus on the Euclidean distance.

The UMAP algorithm builds upon some components, that are particular difficult to efficiently implement on GPUs.
This includes the nearest-neighbor search, which is done with the application of Random Projection trees in the original paper.
To keep development time within a feasible time frame, these subtasks of the algorithm will be solved by reusing existing implementations.

A measurement of the implementation will provide results on its performance.
To put these results into perspective, a comparison with the sequential version will show how much speedup was achieved by using the GPU.
A comparison with the CUDA implementation of the t-SNE algorithm will give an estimation on the advantage of the implementation in practice.

Furthermore the performance of the coarse-grained algorithm steps will be analyzed independently.
This allows insight to which parts should be considered for future optimization attempts.
