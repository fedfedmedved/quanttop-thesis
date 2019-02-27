## Dimensionality Reduction Algorithms
global/local

PCA, t-SNE and UMAP

comparison of graphical results

<!-- first gives a overview of clustering algorithms, followed by an examination of reduction algorithms, concluding with a summary of the thesis' main algorithm, UMAP.-->



<!--nearest neighbor-->



<!--_k-Means_ defines clusters as points centered around one single center, while _DBSCAN_ has an understanding of clusters as point clouds.-->


<!--Contemporary data often is of such high-dimensional complexity that it can often not be visualized by traditional means.-->
<!--Thus visualization of data is nowadays commonly achieved by using dimensionality reduction algorithms.-->

<!--finds clusters of arbitrary shape as long as the data points form a point cloud that is connected densely enough.-->

<!--Due to the curse of dimensionality most clustering algorithms perform badly on data with high-dimensional complexity.-->
<!--Such data can better be visualized by dimensionality reduction algorithms, covered in the subsequent section.-->

<!--PCA and t-SNE are the most widely used-->
<!--<!--Different approaches on wether to -->-->
<!--PCA is a linear dimensionality reduction algorithm-->
<!--t-SNE-->
<!--This thesis' main focus-->
<!--UMAP-->




<!-- and traditionally visualization is coupled to data having a low dimensional complexity, so that it can easily be plotted in a 2D or 3D graph.
Additional dimensions not already covered by the axes can be represented through color, size or other visually distinctive features.
This can for example be used for scientific data gained from simple measurements or for a selective set of features in more complex data.-->

<!--However, in fields such as genomics, medicine or data analysis  TODO check fields in general, the encountered data frequently is more complex and often has thousands of dimensions. Visualizing it is only possible through the reduction of complexity. Dimensionality reduction algorithms are designed to do exactly this, preserving meaningfulness of the data, while lowering the dimensions to a displayable amount of usually two or three. -->

<!--UMAP, the algorithm on which this thesis' main focus lays, reduces dimensions by mapping data points in a way that upholds local structures. By doing so it implicitly clusters points in the lower dimension. Hence, a short preface on clustering algorithms is given, followed by an introduction on dimensionality reduction algorithms. As this thesis ultimately is about parallelization, each algorithm description is also accompanied by a brief analysis on how it can be parallelized.-->



