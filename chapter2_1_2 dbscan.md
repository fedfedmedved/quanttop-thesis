### DBSCAN
One of the biggest disadvantages of the k-Means algorithm is that it relys on the assumption of all clusters having one single center.
This prevents effective discovery of shapes other than spherical, especially non-convex forms.

DBSCAN, short for "Density Based Spatial Clustering of Applications with Noise" was introduced in 1996 by Ester et. al. [@Daszykowski2010].
Instead of assigning each data point to a center, the algorithm takes a different approach.
It considers clusters to be dense point clouds.
If a data point has more than a certain amount of points close to it, DBSCAN defines that area as dense.
All points inside this dense area form a cluster.
For data points inside the cluster that fulfill the same condition enhance the cluster by adding their close neigbors to it.
By repeating this procedure clusters of arbitrary shapes can be found, given that they are fulfilling the density requirement.
Algorithm \autoref{dbscan_algo} shows an outline of how this procedure can be implemented.

\begin{algorithm}[H]
\label{dbscan_algo}
\SetKwInOut{Input}{Input}\SetKwInOut{Output}{Output}
\SetKwRepeat{Do}{do}{while}
\Input{data set to cluster $\mathcal{X} = {x_1, x_2, …, x_n}$,

    \ \ \ \ \ \ \ \ \ \ \ \ \ maximum radius for cluster connectedness $\varepsilon$,

    \ \ \ \ \ \ \ \ \ \ \ \ minimum amount of points needed for a dense region \textit{minPts}. }
\Output{a set of clusters over $\mathcal{X}$. }
\DontPrintSemicolon
\BlankLine
    \For {previously unprocessed data point $x_i \in \mathcal{X}$}{
        retrieve neigbors of $x_i$ within an $\varepsilon$ radius $\mathcal{N}(x_i)$
        
        \eIf {$\mathcal{N}(x_i)$ has more than \textit{minPts}} {
            create new cluster $\mathcal{C}$ consisting of $x_i$ and $\mathcal{N}(x_i)$
            
            initialize search set $\mathcal{S} = \mathcal{N}(x_i)$
            
            \For {all $s \in \mathcal{S}$} {
                retrieve neigbors of $s$ within an $\varepsilon$ radius $\mathcal{N}(s)$
                
                \If{$\mathcal{N}(s)$ has more than \textit{minPts}} {
                    add $\mathcal{N}(s)$ to $\mathcal{C}$ and $\mathcal{S}$
                }
            }
            
        } {
            mark $x_i$ as noise
        }
    }
\caption{k-means.}
\end{algorithm}

The runtime of DBSCAN is claimed to be 

in the original publication [@Daszykowski2010].
This was proven to be incorrect in 2015 [@Gan2015].
dbscan runtime https://www.researchgate.net/publication/300590193_DBSCAN_Revisited
