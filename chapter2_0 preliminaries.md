# Preliminaries {#preliminaries}
"Visual exploration is an essential component of data analysis" as van der Maaten et. al. [@bhtsne] put it.
Clustering algorithms can be used to support visual analysis of data by bundling data points together.
But this is only helpful for low-dimensional data.
High-dimensional data can not easily be put in a human comprehensible form.

Here dimensionality reduction algorithms can aid.
By transforming the original data they create simplified representations with lower dimensionality.
This is commonly used to create two or three dimensional visualizations.

The following sections will give an overview on both, clustering algorithms and dimensionality reduction algorithms.
For each algorithm a description and a broad implementation overview in pseudo code will be given.
Furthermore the time complexity of each algorithm is given and explained.
Eventually, since parallelization is a central element of this thesis, ways to parallelize these algorithms will be covered.

