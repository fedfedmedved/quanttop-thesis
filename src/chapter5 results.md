# Results
In this chapter the new implementation, GPUMAP, is profiled and compared to the CPU implementation and t-SNE CUDA.
[Section 5.1](#performance) contains performance measurements and comparisons, [Section 5.2](#visualization_quality) compares the quality of GPUMAP's visualizations.

## Performance {#performance}
To profile GPUMAP, a similar analysis to that in Chapter 3 is performed.
The hardware and software are the same, but computation power is enhanced by the usage of an Nvidia® TESLA V100™ GPU with 32 GB of Memory.

The times given in Table \ref{gpumap_various_times} show a breakdown of the total time into the times spent on the methods that were parallelized: `nearest_neighbors` (KNN), `fuzzy_simplicial_set` (Fuzzy) and `simplicial_set_embedding` (Embed).
Additionally the accumulated compiling time (JIT) is listed.
Further the total time (Total) of GPUMAP is given together with the speedup achieved over regular UMAP (Speedup).
A visualization of how GPUMAP performs on rising numbers of data points is shown in @fig:gpumap_plot_google_news.

Data set          N     M  Speedup   Total    KNN  Fuzzy  Embed   JIT
------------- ----- ----- -------- ------- ------ ------ ------ -----
Iris            150     4      1.6    5.60   0.01   1.51   3.46  4.10
COIL-20        1440 16384      2.6    6.24   0.14   1.72   3.77  4.19
Digits         1797    64      2.5    5.85   0.24   1.61   3.56  4.05
LFW           13233  2914      8.1    5.91   1.24   0.86   3.13  4.08
COIL-100       7200 49152      8.7   10.40   2.57   0.78   5.62  4.09
MNIST          70 K   784     17.0    9.52   1.93   1.00   5.88  4.15
F-MNIST        70 K   784     17.2    9.73   1.90   1.07   5.98  4.24
CIFAR          60 K  3072     18.9   10.59   3.10   1.01   5.38  4.22
GoogleNews    200 K   300     61.4    9.52   3.38   1.54   3.99  4.21
GoogleNews    500 K   300     59.4   26.57  15.76   3.17   6.95  4.12
GoogleNews      3 M   300     25.7     554    502  18.32  33.16  4.20

Table: Profiling of GPUMAP on various data sets. \label{gpumap_various_times}

For big data sets the total time is solely dominated by the KNN search.
Compared to UMAP, the embedding optimization and fuzzy distance normalization contribute a lower percentage of the overall running time.
For data sets bigger than 100 K data points the embedding is initialized randomly, which is the reason for the drop of execution time in the Embed column.
The time spent on JIT compiling is lower, which is partly due to the new  implementation of the `nearest_neighbors` subtask not needing compilation, since it is handled by calling a precompiled C++ implementation.
Additionally the `fuzzy_simplicial_set` subtask no longer is JIT-compiled, since in GPUMAP it consists mainly of calls to `cupy` and GPU-compiled methods.

![Times taken by GPUMAP subtasks on reduced GoogleNews data sets.](figures/chapter5/plot_google_news.png){width=100% #fig:gpumap_plot_google_news}

In Table \ref{gpumap_tsne} GPUMAP is compared with t-SNE-CUDA.
A comparison on the same hardware was not possible, as no working version of t-SNE-CUDA could be obtained.
Neither the recommended installation method via `conda`, nor a manual compilation version, resulted in working installations, despite closely following the recommended steps of the installation description [^tsne-cuda-repo].
The code repository has issues reported for the encountered errors.

Therefore, the times used for the comparison are from the t-SNE-CUDA publication [@tsne-cuda].
Since they were measured on an Nvidia® Titan X GPU, the performance of t-SNE-CUDA and GPUMAP cannot directly be compared based on the differences.
However, they still capture how the algorithms scale in comparison.
The data sets used are MNIST, CIFAR and the GloVe data set [@glove].
Since the times of [@tsne-cuda] do not include the classification parts of CIFAR and MNIST, the data set sizes are smaller, which is why the times in Table \ref{gpumap_tsne} differ from those of Table \ref{gpumap_various_times}.

Data set          N     M  t-SNE-CUDA                 GPUMAP   JIT  non-JIT   KNN
------------- ----- ----- -----------               -------- ----- -------- -----
MNIST          60 K   784        6.98                   7.74  4.12     3.62  1.40
CIFAR          50 K  3072          12[^quote_cifar]     8.49  4.02     4.47  2.34
GloVe         2.2 M   300         573                    322  4.14      318   284

Table:Comparison of GPUMAP and t-SNE-CUDA on the CIFAR, MNIST and GloVe data sets. \label{gpumap_tsne}

Table \ref{gpumap_tsne} also features columns for the time taken for JIT compilation and the remaining time.
Since t-SNE-CUDA is compiled beforehand, comparing the two algorithms by actual execution time should be done based on the non-JIT time.
Further the KNN column shows the time spent on the `nearest_neighbors` subtask.
Both implementations have such a subtask, that both solve by using the FAISS library.
But while GPUMAP spends ~88% of time on its total time for processing the GloVe data set, the t-SNE-CUDA publication only lists an approximate percentage between 12%-15% spent on the subtask.
In absolute numbers this would mean a time of 69 to 86 seconds spend for the KNN search, which is less than one third of the time GPUMAP takes.

## Visualization Quality {#visualization}
As the most common use case of UMAP is to perform dimensionality reduction for visualizations, GPUMAP needs to provide visualizations of similar quality to be viable.
@fig:umap_gpumap_viz_small and @fig:umap_gpumap_viz_big show comparisons of UMAP on the left and GPUMAP on the right.

As can be seen the visualizations produced by GPUMAP contain more "noise".
Points are not as closely clustered together as the UMAP equivalents.
Especially for small data sets this is visible.
The points of the small Iris data set are spread out, even though GPUMAP already uses twice as many epochs for the creation of the embedding than UMAP.

For the COIL-20 data set, the circular shapes formed by UMAP are not reproduced by GPUMAP.
While the points are still grouped together in the same way as UMAP, they form clumps or trails of points instead of circles.
Further a group of points was located to the bottom of the visualization, which causes the visualization to look more distorted and even less similar looking to the visualization of UMAP.

<div id="fig:umap_gpumap_viz_small" class="subfigures">
![Iris by UMAP](figures/chapter5/umap/iris.png){#fig:umap_iris width="49%"}
\hfill
![Iris by GPUMAP](figures/chapter5/gpumap/iris.png){#fig:gpumap_iris width="49%"}

![COIL-20 by UMAP](figures/chapter5/umap/coil_20.png){#fig:umap_coil_20 width="49%"}
\hfill
![COIL-20 by GPUMAP](figures/chapter5/gpumap/coil_20.png){#fig:gpumap_coil_20 width="49%"}

Comparison of visualizations by GPUMAP and UMAP on Iris and COIL-20.
</div>

For bigger data sets the observed "noise" carries less weight as for small data sets.
The produced visualizations of GPUMAP are more or less aligned with those of UMAP.
The clusters of MNIST and F-MNIST are clearly recognizable and closely resemble those produced by UMAP.

<div id="fig:umap_gpumap_viz_big" class="subfigures">
![MNIST by UMAP](figures/chapter5/umap/mnist.png){#fig:umap_mnist width="45%"}
\hfill
![MNIST by GPUMAP](figures/chapter5/gpumap/mnist.png){#fig:gpumap_mnist width="45%"}

![F-MNIST by UMAP](figures/chapter5/umap/fashion_mnist.png){#fig:umap_fashion_mnist width="45%"}
\hfill
![F-MNIST by GPUMAP](figures/chapter5/gpumap/fashion_mnist.png){#fig:gpumap_fashion_mnist width="45%"}

![GoogleNews by UMAP](figures/chapter5/umap/google_news_full.png){#fig:umap_google_news_full width="45%"}
\hfill
![GoogleNews by GPUMAP](figures/chapter5/gpumap/google_news_full.png){#fig:gpumap_google_news_full width="45%"}

Comparison of visualizations by GPUMAP and UMAP on MNIST, F-MNIST and GoogleNews.
</div>

[^tsne-cuda-repo]:`https://github.com/CannyLab/tsne-cuda/wiki/Installation`, accessed 28.04.2019
[^quote_cifar]: "we can run on the full [CIFAR] set in under 12 seconds", stated in [@tsne-cuda], p. 5.

