# Preliminaries {#preliminaries}
"Visual exploration is an essential component of data analysis" as van der Maaten et. al. [@bhtsne] put it.
Clustering algorithms can be used to support visual analysis of data by grouping data points.
But this is only helpful for low-dimensional data.
High-dimensional data can not easily be represented in a human comprehensible form.

Here, dimensionality reduction algorithms can aid.
By transforming the original data they create low-dimensional representations.
This is commonly used to create two or three dimensional visualizations.

The following sections will give an overview on both, clustering algorithms and dimensionality reduction algorithms.
For each algorithm a description and a general implementation overview in pseudo code will be given.
Furthermore, the time complexity of each algorithm is given and explained.
Eventually, since parallelization is a central element of this thesis, each algorithm is also accompanied by a brief analysis on how it can be parallelized.

