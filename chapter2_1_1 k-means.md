### K-Means
K-Means, also known as _Lloyd's algorithm_, is a clustering algorithm from 1957 [@Lloyd1982], which clusters a given set of data points into a pre-defined amount of $K$ clusters. It does so by first randomly selecting $K$ points from the data and defining them as cluster centers. Then it alternates between the following two steps:

1. Assign each data point to the cluster closest to it.

2. Recalculate the clusters' centers by averaging all points belonging to one cluster.

These steps are repeated until the clusters' centers are no longer repositioned. Figure @fig:kmeansconvergence shows an examplary convergence of the algorithm.

![Shown are the intermediary steps of the _K-Means_ algorithm until convergence. (a) starts by defining two arbitrary cluster centers. Every other step from (b) on is assigning the points to the cluster nearest to them (indicated by a line). In between the assignment steps the cluster centers are recalculated. The figure is taken from [@Bishop2007], figure 9.1](figures/chapter2/kmeans.png){#fig:kmeansconvergence short-caption="Convergence of the _K-Means_ algorithm."  width="80%"}




The resulting clusters are

The theoretical runtime of this is 

Parallelization:

Step 1 


