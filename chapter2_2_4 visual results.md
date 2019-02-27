### Visual Results
To compare the visualization results of the aforementioned algorithms, @fig:viz_compare shows visualizations of each algorithm for several data sets.
The MNIST data set [@mnist] is a commonly used example of assessing the quality of dimensionality reduction algorithms.
The figure shows that the quality of PCA is inferior to those of t-SNE and UMAP.
The points in the graphic output of PCA look merely spread out, unlike the visualizations of the other competitors, which both show clearly recognizable clusters.
The labels represented as colors show that the clusters also are correctly formed and consist of similar data.

The differences between t-SNE and UMAP are not quite as grave, but nonetheless very noticeable.
The clusters formed by t-SNE are closer together and not as dense as those created by UMAP.
Additionally UMAP has less noise in between the clusters and shows no split clusters as t-SNE does in the lower part of its visualization.

![Visualizations of data sets by PCA, t-SNE and UMAP. The figure is modified from the UMAP publication [@umap], figure 2.](figures/chapter2/modified_umap_graphic.png){#fig:viz_compare short-caption="Visualizations of data sets by PCA, t-SNE and UMAP."  width="100%"}

