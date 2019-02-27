### K-Means
K-Means, also known as Lloyd's algorithm, is a clustering algorithm publically published in 1982  [@Lloyd1982].
It is a standard algorithm for finding clusters and is frequently used in machine learning and related fields.
Common libraries used in these fields include implementations of the k-means algorithm, i.e. tensorflow [^kmeans_tf] and scikit-learn [^kmeans_scikit].

k-means is based on a centroid approach to clusters.
It expects a cluster to be representable through its centroid, the mean of all points belonging to the cluster.
This intuitive concept of clusters reduces the task of finding all clusters to finding the center of each cluster.
If the amount of clusters is known beforehand, then a converging algorithm such as k-means can be constructed.

Starting with a randomized initialization for all $k$ centroids, k-means assigns each data point to the centroid closest to it.
As a distance measure the Euclidean metric is used.
After every point was processed, the clusters' centers are recalculated.
New centroids are calculated by averaging over the positions of all data points belonging to a cluster.
The previous steps are repeated until the algorithm eventually converges.
Convergence has been reached when the centroids are no longer moved.
The result is a desired partitioning of the data into $k$ clusters.

Algorithm \autoref{kmeans_algo} shows a pseudo code version of k-means.
@fig:kmeansconvergence shows how the algorithm converges by repeating the steps of assigning points to the closest cluster centroid and repositioning the centroids according to the points they represent.

\begin{algorithm}[H]
\label{kmeans_algo}
\SetKwInOut{Input}{Input}\SetKwInOut{Output}{Output}
\SetKwRepeat{Do}{do}{while}
\Input{data set to cluster $\mathcal{X} = {x_1, x_2, …, x_n}$

 \ \ \ \ \ \ \ \ \ \ \ \ \ amount of clusters $k$. }
\Output {a set of clusters over $\mathcal{X}$. }
\DontPrintSemicolon
\BlankLine
    randomly initialize $k$ cluster centroids $\mathcal{C} = {\mu_1, \mu_2, …, \mu_k}$
    
    \Do {centroid positions changed in previous step}{
        \ForEach {data point $x_i \in \mathcal{X}$} {
            assign $x_i$ to the cluster closest to it (minimize $||x_i - \mu_k||$ with $\mu_k \in \mathcal{C}$)
        }
        \ForEach {centroid $\mu_i \in \mathcal{C}$} {
            recalculate $\mu_i$ by averaging all points belonging it
        }
    }
\caption{k-means}
\end{algorithm}

The algorithm has a time complexity of $\mathcal{O}(i k N M)$.
$I$ hereby refers to the amount of iterations and is no input parameter.
As stated in [@Manning2012], p. 364, $i$ can be fixed, as after a certain amount of steps the found clusters don't undergo any further drastic changes.
The remaining complexity stems from inside the main algorithm loop.
For each of the $N$ data points the Euclidean distance over all $M$ dimensions is calculated to each of the $k$ clusters.
The repositioning of the $K$ clusters has a lower complexity of $N M$ since each data point is only used in the calculation of its respective centroids' new mean.
So overall k-means is linear in the amount of clusters, number of data points and data dimensions.

While k-means is commonly fast due to this linear nature, it also has multiple downsides.
The input of $k$ requires a user to know how many clusters the data consists of.
A common solution to this problem is to run k-means with numerous inputs of $k$.
Another problem is that of data being clustered in unexpected, counterintuitive ways.
This problem often arises when data has clusters of varying size or density.
Several variants such as k-means++ [@Arthur2007] try to solve this problem by improving the initialization of the centroids.
<!--more: https://arxiv.org/abs/1209.1960-->
<!--possible example http://varianceexplained.org/r/kmeans-free-lunch/-->
<!--downside: noise-->
The theoretical problem that k-means does not always find the optimal cluster assignment is still unavoidable.
As shown in [@Aloise2009], finding clusters "in general dimension is NP-hard for $k=2$".
Thus a linear algorithm can only ever provide an approximation.

Parallelization of k-means can be achieved straightforward.
The assignment step, where data points are assigned to clusters, can be computed independently for each data point.
Similarly the repositioning of the centroids can be done in parallel, since the centroid positions are independent of one another.
In between these steps synchronization is needed.
Parallelized implementations using MPI and OpenMP [^kmeans_mpi] exist, as well as a CUDA version that uses data parallelism [^kmeans_cuda].

![Shown are the intermediary steps of the k-means algorithm until convergence. (a) starts by defining two arbitrary cluster centers. The remaining steps show the alternation between assigning the points to the cluster nearest to them (indicated by a line) and recalculating the cluster centers. The figure is taken from [@Bishop2007], figure 9.1.](figures/chapter2/kmeans.png){#fig:kmeansconvergence short-caption="Convergence of the k-means algorithm."  width="69%"}


[^kmeans_tf]: https://www.tensorflow.org/api_docs/python/tf/contrib/factorization/KMeans, last accessed 20.04.2019
[^kmeans_scikit]: https://scikit-learn.org/stable/modules/generated/sklearn.cluster.KMeans.html, last accessed 20.04.2019
[^kmeans_cuda]: https://github.com/serban/kmeans, last accessed 20.04.2019
[^kmeans_mpi]: http://users.eecs.northwestern.edu/~wkliao/Kmeans/index.html, last accessed 20.04.2019
