# Preliminaries {#preliminaries}
"Visual exploration is an essential component of data analysis" as van der Maaten et. al. [@bhtsne] put it.
Classic visualization techniques, such as scatter plots and parallel coordinates, can be used for visual analysis of low-dimensional data.
They can be combined with clustering algorithms to improve the graphical results by grouping data points.
However, these methods of visualization can not be applied to high-dimensional data.
Here, dimensionality reduction algorithms can aid, which are commonly used for visualization by lowering the dimensionality to two or three dimensions.

The following sections will give an overview on clustering algorithms and dimensionality reduction algorithms.
For each algorithm a description and a general implementation overview in pseudo code will be given.
Furthermore, the time complexity of each algorithm is given and explained.
Eventually, since parallelization is a central element of this thesis, each algorithm is also accompanied by a brief analysis on how it can be parallelized.

