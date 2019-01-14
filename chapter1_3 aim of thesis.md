## Aim of the Thesis
In this thesis the UMAP algorithm is to be implemented in a parallel manner on graphic cards. The CUDA [@cuda] technology is used for parallel execution on GPUs.
<!--This choice was made due to experience and widespread usage-->
While the original implementation of UMAP supports a wide range of distance metrics, our implementation will exclusively focus on the Euclidean distance.

The UMAP algorithm builds upon some components, that are particular difficult to efficiently implement on GPUs, such as nearest neighbor search with Random Projection trees. For those existing implementations are reused, so that development time can stay within a feasible time frame.

A measurement of the implementation provides results on it's performance.
To put these results into perspective, a comparison with the sequential version will show how much speedup was achieved by using the GPU.
A comparison with the CUDA implementation of the t-SNE algorithm gives an estimation on the advantage of the implementation in practice.

Furthermore the performance of the coarse-grained algorithm steps will be analysed independently.
This allows insight to which parts should be considered for future optimisation attempts.
