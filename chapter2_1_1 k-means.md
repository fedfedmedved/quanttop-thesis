### K-Means
K-Means, also known as Lloyd's algorithm, is a clustering algorithm publically published in 1982  [@Lloyd1982].
It is a standard algorithm for finding clusters and is commonly used in machine learning and related fields.
<!--Common libraries used in the field, such as tensorflow and scikit-learn include implementations of it.-->

Algorithm \autoref{kmeans_algo} shows an abstract version of k-means.
The input of $k$ requires the user to know how many clusters the data contains.
The algorithm then tries to fit the input data into $k$ clusters by repeating the steps of assigning points to the closest cluster centroid and repositioning the centroids according to the points they represent.


The problem of finding clusters "in general dimension is NP-hard for $k=2$" as shown in [@Aloise2009]


However, variations that do not require this exist.

nonprobabilistic technique


It clusters a given set of data points into a pre-defined amount of $k$ clusters.


The clusters consist of centroids and data points assigned to the
 are centered around It does so by first randomly selecting $K$ points from the data and defining them as cluster centers. Then it alternates between the following two steps:

\begin{algorithm}[H]
\label{kmeans_algo}
\SetKwInOut{Input}{Input}\SetKwInOut{Output}{Output}
\SetKwRepeat{Do}{do}{while}
\Input{data set to cluster $\mathcal{X} = {x_1, x_2, …, x_n}$
    \ \ \ \ \ \ \ \ \ \ \ \ \ \ amount of clusters $k$. }
\Output {a set of clusters over $\mathcal{X}$. }
\DontPrintSemicolon
\BlankLine
    initialize $k$ cluster centroids $\mu_k$
    
    \Do {centroid clusters changed in previous step}{
        assign each data point to the cluster closest to it
        
        recalculate the clusters' centers by averaging all points belonging to one cluster
    }
\caption{k-means.}
\end{algorithm}



These steps are repeated until the clusters' centers are no longer repositioned.

Figure @fig:kmeansconvergence shows an examplary convergence of the algorithm.

![Shown are the intermediary steps of the _K-Means_ algorithm until convergence. (a) starts by defining two arbitrary cluster centers. Every other step from (b) on is assigning the points to the cluster nearest to them (indicated by a line). In between the assignment steps the cluster centers are recalculated. The figure is taken from [@Bishop2007], figure 9.1](figures/chapter2/kmeans.png){#fig:kmeansconvergence short-caption="Convergence of the _K-Means_ algorithm."  width="80%"}


superpolynomial worst-case
NP-hard in general Euclidean space

only centroid based clusters
needs k

Multiple variants have been introduced since, all building on its simplicity.



<!--The resulting clusters are-->

<!--The theoretical runtime of this is -->

<!--Parallelization:-->

<!--Step 1 -->


