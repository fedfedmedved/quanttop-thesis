### DBSCAN
One of the biggest disadvantages of the k-Means algorithm is that it relies on the assumption of all clusters having one single center.
This effectively prevents discovery of shapes other than spherical, especially non-convex forms.

DBSCAN, short for "Density Based Spatial Clustering of Applications with Noise" was introduced in 1996 by Ester et. al. [@dbscan].
Instead of assigning each data point to a center, the algorithm takes a different approach.
It considers clusters to be dense point clouds.
@fig:dbscanexample [^dbscan_example_src] shows examples for this.

If a data point has more than a certain amount of points close to it, DBSCAN defines that area as dense.
All points inside this dense area form a cluster.
A cluster is discovered by starting from a data point with enough other points in its close neighborhood.
For the point and it's neighbors a new cluster is created.
All neighboring points that also fulfill the criteria of having enough points in their own neighborhood are used to expand the cluster by adding these neighbors to the cluster.
Through repeating this procedure clusters of arbitrary shapes can be found, given that they are connected strongly enough and also fulfill the density requirement.
Algorithm \autoref{dbscan_algo} shows an outline of how an implementation of the algorithm could proceed.

\begin{algorithm}[H]
\label{dbscan_algo}
\SetKwInOut{Input}{Input}\SetKwInOut{Output}{Output}
\SetKwRepeat{Do}{do}{while}
\Input{data set to cluster $\mathcal{X} = {x_1, x_2, …, x_n}$,

    \ \ \ \ \ \ \ \ \ \ \ \ \ maximum radius for cluster connectedness $\varepsilon$,

    \ \ \ \ \ \ \ \ \ \ \ \ \ minimum amount of points needed for a dense region \textit{minPts}.}
\Output{a set of clusters over $\mathcal{X}$. }
\DontPrintSemicolon
\BlankLine
    \For {previously unprocessed data point $x_i \in \mathcal{X}$}{
        retrieve neighbors of $x_i$ within an $\varepsilon$ radius $\mathcal{N}(x_i)$
        
        \eIf {$\mathcal{N}(x_i)$ has more than \textit{minPts}} {
            create new cluster $\mathcal{C}$ consisting of $x_i$ and $\mathcal{N}(x_i)$
            
            initialize search set $\mathcal{S} = \mathcal{N}(x_i)$
            
            \ForEach {$s \in \mathcal{S}$} {
                retrieve neighbors of $s$ within an $\varepsilon$ radius $\mathcal{N}(s)$
                
                \If{$\mathcal{N}(s)$ has more than \textit{minPts}} {
                    add $\mathcal{N}(s)$ to $\mathcal{C}$ and $\mathcal{S}$
                }
            }
            
        } {
            mark $x_i$ as noise
        }
    }
\caption{DBSCAN}
\end{algorithm}

![Example of non-convex clusters found by DBSCAN.](figures/chapter2/dbscan_example.png){#fig:dbscanexample short-caption="Example of non-convex clusters found by DBSCAN."  width="50%"}

The original publication [@dbscan] claims the time complexity of DBSCAN to be $\mathcal{O}(N \log(N))$, at least in practice.
This can be achieved by the usage of R*-trees for spatial queries, so that the neighbor search can on average be done in $\mathcal{O}(\log(N))$.
Since every point is only processed once, this leads to the claimed average complexity.

As stated in [@Gan2015], the worst case runtime complexity of DBSCAN still remains $\mathcal{O}(N^2)$.
Furthermore it is shown that the best algorithm to solve the same problem as DBSCAN in three or higher dimensional space can not be faster than $\Omega(N^{(4/3)})$, unless unexpected breakthroughs in fundamental problems are achieved.
The publication presents an approximating variant of DBSCAN which has a guaranteed time complexity of $\mathcal{O}(N)$ and which yields results are equal to those of DBSCAN within a certain margin of error.

[parallelization goes here]
<!--TODO-->

[^dbscan_example_src]: The graphic of @fig:dbscanexample was taken from https://www.datanovia.com/en/lessons/dbscan-density-based-clustering-essentials/, last accessed 20.4.2019

