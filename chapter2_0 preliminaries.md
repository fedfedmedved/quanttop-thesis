# Preliminaries {#preliminaries}
"Visual exploration is an essential component of data analysis" as van der Maaten et. al. [@Maaten2014] put it.
This statement has been true long before data could be as large and complex as today.
Clustering algorithms, covered in the next section [#clustering], can help visualizing data by bundling related data points.
Common algorithms are k-Means and
Due to the curse of dimensionality clustering algorithms often perform badly on data with high-dimensional complexity.

If the data is of high-dimensional complexity then clustering algorithms often perform badly and their results can't be used for visualization.


Here dimensionality reduction algorithms, covered in the subsequent section, can help.


Clustering




<!-- and traditionally visualization is coupled to data having a low dimensional complexity, so that it can easily be plotted in a 2D or 3D graph. Additional dimensions not already covered by the axes can be represented through color, size or other visually distinctive features. This can for example be used for scientific data gained from simple measurements or for a selective set of features in more complex data.-->

<!--However, in fields such as genomics, medicine or data analysis  TODO check fields in general, the encountered data frequently is more complex and often has thousands of dimensions. Visualizing it is only possible through the reduction of complexity. Dimensionality reduction algorithms are designed to do exactly this, preserving meaningfulness of the data, while lowering the dimensions to a displayable amount of usually two or three. -->

<!--UMAP, the algorithm on which this thesis' main focus lays, reduces dimensions by mapping data points in a way that upholds local structures. By doing so it implicitly clusters points in the lower dimension. Hence, a short preface on clustering algorithms is given, followed by an introduction on dimensionality reduction algorithms. As this thesis ultimately is about parallelization, each algorithm description is also accompanied by a brief analysis on how it can be parallelized.-->




