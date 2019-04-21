## Algorithm Complexity Overview
The algorithms of this chapter all have varying complexities for both required time to execute the algorithm, as well as space required by it.
To recapitulate, the following table gives a condensed overview of these complexities.
As before, $N$ denotes the amount of data points in the input data and $M$ denotes their dimensionality.
Additionally, for dimensionality reduction algorithms $\widetilde{M}$ denotes the amount of dimensions to reduce to.

|Algorithm|Time Complexity|Space Complexity|Notes|
|----------------|--------------|-------------|-------------------------|
|K-Means|$\mathcal{O}(K \cdot N \cdot M)$|$\mathcal{O}(N \cdot M)$|$K$ number of clusters to find|
|DBSCAN|$\mathcal{O}(N^2 \cdot M)$ | $\mathcal{O}(N)$||
|PCA|$\mathcal{O}(M^2 \cdot N + M^3)$ | $\mathcal{O}(N \cdot M)$||
|t-SNE|$\mathcal{O}(N^2)$|$\mathcal{O}(N^2)$|$M$ contained in $N$|
|Barnes-Hut t-SNE|$\mathcal{O}(N \cdot log(N))$|$\mathcal{O}(N)$|$M$ contained in $N$|
|UMAP|$\mathcal{O}((N \cdot M)^{1.14})$|$\mathcal{O}((K + \widetilde{M}) \cdot N)$|$K$ for the KNN algorithm|

