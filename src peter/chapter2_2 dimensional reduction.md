## Dimensionality Reduction Algorithms
"Visual exploration is an essential component of data analysis" as van der Maaten et. al. [@bhtsne] put it.
As seen in the previous section, classic visualization techniques, such as scatter plots and parallel coordinates, can be used for visual analysis of low-dimensional data.
But for data with hundreds or thousands of dimensions these methods cannot effectively be applied anymore.
Such high-dimensional data is common in fields as genomics, medicine and machine learning.
Exploratory data analysis is nonetheless important in these fields, therefore a way to visualize the data is desirable.
Here, dimensionality reduction algorithms can aid, by creating low-dimensional representations of high-dimensional data.
In general dimensionality reduction algorithms can be useful for a multitude of applications, however, this thesis only takes interest in using them as means of visualization.

In the following sections the commonly used algorithms PCA and t-SNE will be covered.
Furthermore the central algorithm of the thesis, UMAP, will be introduced.
PCA is a linear transformation, that preserves the global structure of its input data, whereas t-SNE and UMAP are non-linear dimensionality reduction methods, that preserve the local structure of the input data.
Especially UMAP tries to preserve both, global and local structure alike.
To highlight the difference between the graphical results of the algorithms, a comparison of them is given as a conclusion to the chapter.

### PCA
One of the most commonly used dimensionality reduction algorithms is Principal Components Analysis (PCA).
Its origins are "difficult to trace" according to [@Jolliffe2002].
They lie within the beginning of the 20th century, but throughout history, PCA has been discovered multiple times, which is an indicator of how fundamental the algorithm is.
It is a versatile algorithm with multiple applications, that is still frequently referenced and used in current research publications.
A common application in the field of data analysis is that of visualizing data.

<!--What PCA does-->
PCA is a statistical method to reduce data dimensionality.
It creates a linear transformation of the data utilizing the data's variance.
In simple terms, PCA finds a set of vectors that describe the dimensions in which the data is the most spread out.
These vectors are the principal components of the data.

If the input data is interpreted as a matrix $\mathbf{X} = (\mathbf{x}_{ij})$, then the principal components of $\mathbf{X}$ are equivalent to its eigenvectors.
They are independent of each other, as all eigenvectors are orthogonal to one another.
The eigenvalues $\lambda_i$ that correspond to the eigenvectors $\overline{\mathbf{e}}_i$, describe how high the data's variance along the respective eigenvector is.

Sorting the eigenvectors according to their eigenvalues will result in a sorted list $\mathcal{E} = {(\overline{\mathbf{e}}_1, \lambda_1), …, (\overline{\mathbf{e}}_N, \lambda_N)}$, in which the principal components that contribute the most to the
 variance of $\mathbf{X}$ are listed first.
Respectively the later entries in the list contribute the least variance and therefore also hold the least information on the nature of the data in $\mathbf{X}$.

Following the procedure, the dimensionality of $\mathbf{X}$ can be lowered by keeping only the first $\widetilde{M}$ principal components.
This transformation looses as little variance of the data as possible and thus preserves as much of the data's information.
While the data can also lay on a manifold embedded in a high-dimensional space, PCA is a linear dimensionality reduction algorithm and merely has insight on the global structure of the data.

PCA starts by centering the input data according to the mean value in each direction.
The $M$-dimensional input data $\mathbf{X} = {\mathbf{x}_1, …, \mathbf{x}_N}$ is interpreted as an $N \times M$ matrix.
Each of the $N$ data points can hereby be thought of as as an observation of $M$ variables.
A mean vector $\mathbf{\bar{m}}$ is calculated by normalizing the sum of all input data points $\mathbf{\bar{m}} = \frac{1}{N} \sum_{\mathbf{x}_i \in \mathbf{X}} \mathbf{x}_i$.
The centered version of $\widetilde{\mathbf{X}} = {\tilde{\mathbf{x}}_1, …, \tilde{\mathbf{x}}_N}$ is then obtained by setting $\tilde{\mathbf{x}}_i = \mathbf{x}_i - \bar{m}$.

In the next step the centered matrix is used to calculate the covariance matrix $\mathbf{C} = \frac{1}{N - 1} \widetilde{\mathbf{X}}^T \widetilde{\mathbf{X}}$.
Through diagonalizing $\mathbf{C}$, the eigenvectors $\mathbf{e}_i$ and eigenvalues $\lambda_i$ are retrieved.
Sorting them by decreasing eigenvalues yields $\mathcal{E} = {(\mathbf{e}_1, \lambda_1), …, (\mathbf{e}_N, \lambda_N)}$.
The first $\widetilde{M}$ eigenvectors are the sought principal components.

From the selected eigenvectors a $M \times \widetilde{M}$ matrix $\mathbf{W}$ can be constructed by using the eigenvectors as matrix columns.
Finally, the matrix $\mathbf{W}$ can be used to create a low-dimensional representation $\mathbf{Y}$ for the input data $\mathbf{X}$ with $\mathbf{Y} = \mathbf{W} \cdot \mathbf{X}$.

\begin{algorithm}[H]
\label{pca_algo}
\SetKwInOut{Input}{Input}\SetKwInOut{Output}{Output}
\SetKwRepeat{Do}{do}{while}
\Input{$M$-dimensional data set $\mathbf{X} = {\mathbf{x}_1, …, \mathbf{x}_N}$,

\ \ \ \ \ \ \ \ \ \ \ \ \ number of dimensions to reduce to $\widetilde{M}$. }
\Output {$\widetilde{M}$-dimensional representation $\mathbf{Y}$ of $\mathbf{X}$.}
\DontPrintSemicolon
\BlankLine
    mean of $\mathbf{X}$, $\bar{m} \gets \frac{1}{N} \sum_{\mathbf{x}_i \in \mathbf{X}} \mathbf{x}_i$
    
    calculate centered matrix $\widetilde{\mathbf{X}} \gets (\mathbf{x}_i - \bar{m})$.

    covariance matrix $\mathbf{C} = \frac{1}{N-1} \widetilde{\mathbf{X}}^T \times \widetilde{\mathbf{X}}$
    
    diagonalize $\mathbf{C}$ to compute the eigenvectors and eigenvalues $\mathcal{E} = {(\mathbf{e}_1, \lambda_1), …, (\mathbf{e}_N, \lambda_N)}$
    
    sort $\mathcal{E}$ by decreasing eigenvalue
    
    create $N \times \widetilde{M}$-dimensional matrix $\mathbf{W}$ using the first $\widetilde{M}$ eigenvectors of $\mathcal{E}$

    low-dimensional representation $\mathbf{Y} = \mathbf{W} \cdot \mathbf{X}$
    
\caption{Principal Components Analysis.}
\end{algorithm}

Calculating the covariance matrix has a time complexity of $\mathcal{O}(M^2 \cdot N)$ for a naive implementation of matrix multiplications.
Additionally the diagonalization of the covariance matrix has a time complexity of $\mathcal{O}(M^3)$.
Thus, this PCA variant has an overall time complexity of $\mathcal{O}(M^2 \cdot N + M^3)$.

Faster PCA variants exist.
Instead of calculating the covariance matrix, these variants use either other methods to calculate the eigenvectors and -values, such as Singular Value Decomposition (SVD), or calculate one principal component after another in an iterative process.

Parallelizing PCA can be done without any changes to the algorithm.
All performed operations can be composed of BLAS (Basic Linear Algebra Subprograms) operations.
They are therefore already available in a multitude of parallel libraries, such as OpenBLAS [^openblas_web] or cuBLAS [@cublas].
Andercut et al. used the cuBLAS library to implement a GPU version of a PCA variant in [@Andrecut2008] and received a 12 times speedup over their parallel CPU implementation.

<!--pre processing for other algorithms-->

### t-SNE {#tsne}
t-SNE is the state of the art dimensionality reduction algorithm for visualizing high-dimensional data.
It was introduced by Van der Maaten et al. in 2008 [@tsne].
The name is derived from Stochastic Neighbor Embedding (SNE) [@sne], of which t-SNE is a variation.
The t stems from its usage of the Student's t-distribution, one of several modifications introduced by t-SNE.

<!--good graphics-->
The publication shows that t-SNE's graphical results surpass those of other related algorithms.
@fig:coil20_tsne provides an example for this, a comparison between visualizations on the basis of the COIL-20 data set [@coil20].
The COIL-20 data set is composed of picture series from 20 different objects, each photographed from 72 equidistant angles by a camera orbiting the object.
As can be seen, t-SNE captures the circular nature of the data well.
It correctly represents the data of several objects as closed loops, while the algorithms used for comparison can at best display the data in a curved form.

![Visualizations of the COIL-20 data set [@coil20] by a) t-SNE, b) Sammon mapping, c) Isomap and d) LLE. The graphic is taken from  [@tsne], Figure 5.](figures/chapter2/coil20_tsne.png){#fig:coil20_tsne short-caption="Visualizations of the COIL-20 data set."  width="70%"}

<!--bhtsne-->
In 2014 a refined version, Barnes-Hut t-SNE, was published by van der Maaten [@bhtsne].
It reduces the runtime of the algorithm significantly, while providing the same quality of graphical output.
Since there are no real differences for users of the algorithm, the Barnes-Hut version is commonly referred to by t-SNE.
To keep its terminology aligned, this thesis does the same.
The following algorithm description also focuses on the refined version, while still describing the differences between the two.

The basic concept of t-SNE is to find a low-dimensional representation of the input data, that preserves the structure of the input data as well as possible.
Thus, a way to measure the quality of such a low-dimensional representation is needed.
For this t-SNE uses the Kullback-Leibler divergence $f_{KL}()$.
From both, the original data $\mathbf{X} = {\mathbf{x}_1, …, \mathbf{x}_N}$ and the low-dimensional representation $\mathbf{Y} = {y_1, …, y_N}$, probability distributions are determined.
These probability distributions describe the affinities between all points in the respective data.
$P=(p_{ij})$ contains all affinities of points $\mathbf{x}_i, \mathbf{x}_j \in \mathbf{X}$, $Q=(q_{ij})$ all of $y_i, y_j \in \mathbf{Y}$.

$P$ and $Q$ are calculated based on a distance function $dist()$, to capture the layout of the data.
By default t-SNE uses the Euclidean metric, but any other distance function can be used too.
Data points that have a short distance from one another are assigned a high affinity, while those further apart from each other receive a low affinity.

In the same manner that every point $\mathbf{x}_i \in \mathbf{X}$ has a low-dimensional representation $y_i \in \mathbf{Y}$, every $p_{ij}$ responds to a $q_{ij}$.
Comparing $p_{ij}$ with $q_{ij}$ shows how well the affinity between $\mathbf{x}_i$ and $\mathbf{x}_j$ is preserved by their low-dimensional counterparts $y_i$ and $y_j$.
This comparison is done with the Kullback-Leibler divergence.
Using it on all pairs of $p_{ij} \in P$ and $q_{ij} \in Q$, the quality of the low-dimensional representation is assessed.
As a consequence a cost function $C = f_{KL}(P||Q) = \sum\limits_i \sum\limits_j p_{ij} \log(\frac{p_{ij}}{q_{ij}})$ can be formulated.
The lower the Kullback-Leibler divergence between the probability distribution, the better the found representation $\mathbf{Y}$.

t-SNE minimizes $C$ by using the gradients $\frac{\delta \mathcal{C}}{\delta y_i}$.
Each gradient describes how $C$ changes in relation to the respective $y_i$.
Using a learning rate parameter $\eta$ and a time-dependent momentum parameter $\alpha(t)$, t-SNE improves $\mathbf{Y}$ with a gradient descent procedure, according to the formula $\mathbf{Y}^{(t)} = \mathbf{Y}^{(t-1)} + \eta \frac{\delta \mathcal{C}}{\delta \mathbf{Y}} + \alpha (t)(\mathbf{Y}^{(t-1)}-\mathbf{Y}^{(t-2)})$.

\pagebreak

This fundamental approach of t-SNE is the same for both, the original and the Barnes-Hut variant.
The two big improvements made by the Barnes-Hut variant are a) neglect of infinitesimal probabilities when calculating the probability distributions $p_{ij}$ and b) summarizing similar probability distributions when calculating $q_{ij}$, to speed up the gradient calculation.
Both are achieved by using tree data structures.

Through the usage of a vantage-point tree, as introduced in [@Yianilos1993], a $K$-Nearest-Neighbors (KNN) search is performed.
For each point $\mathbf{x}_{i}$ only the $K$ found nearest-neighbors $\mathcal{N}_K(\mathbf{x}_i)$ are used to calculate the probability distributions.
All other probability distributions with $\mathbf{x}_j \notin \mathcal{N}_K(\mathbf{x}_i)$ are ignored by defining $p_{ij} = 0$.
These nulled affinities can be omitted when storing $P$ by using a sparse data structure, reducing the otherwise needed $\mathcal{O}(N^2)$ space complexity to a linear $\mathcal{O}(N)$.

The $K$ parameter of the KNN search is provided by using a multiple of the user-defined perplexity input parameter $perp$.
"The perplexity can be interpreted as a smooth measure of the effective number of neighbors.", as is stated in [@tsne].
So the choice of $perp$ should be made based on the amount of neighbors that a data point is expected to have on average, "typical values are between 5 and 50".
The perplexity parameter was already present in the original t-SNE variant, despite the lack of such a KNN search.
Instead it was and still is used to normalize the probability distributions of $P$.
To simplify the algorithm description, further details on the parameter are omitted here, they can be found in the publication [@tsne].

The low-dimensional representation $\mathbf{Y}$ is initialized randomly.
Through the gradient descent procedure described above, $\mathbf{Y}$ is shaped to better represent $\mathbf{X}$.
A majority of the probability distributions $q_{ij}$, upon which this procedure builds, are small, resulting from many points having a big distance from one another.
Individually these $q_{ij}$ contribute very little to the gradient $\frac{\delta \mathcal{C}}{\delta \mathbf{Y}}$.
It is desirable not to calculate all of them, in order to accelerate the algorithm.
However, while they are negligible on their own, the amount of such $q_{ij}$ is too high to discount all.

![The quadtree structure shown on the left side is used by the Barnes-Hut algorithm to group data points as shown on the right side. Distances from the starting point, the x mark, can be calculated faster this way. The graphic is taken from  [@Barnes1986], Figure 1.](figures/chapter2/barnes_hut.png){#fig:barnes_hut short-caption="Tree structure used by the Barnes-Hut algorithm."  width="60%"}

Therefore, t-SNE utilizes the Barnes-Hut algorithm [@Barnes1986].
It creates a spatial tree, e.g. a quad tree for two dimensional space, and uses it to summarize distances between data points that are far apart.
If a point has approximately the same distance to a group of other points, this group will be treated as a single point, using the average of the group's positions to calculate the distance.
This average is pre-calculated for each space partition in the tree and does not cause overhead per query.
@fig:barnes_hut shows an example of how data points are grouped with the tree structure.
Calculating the distances between all points can hereby be sped up, since fewer calculations are needed.

\begin{algorithm}[H]
\label{tsne_algo}
\SetKwInOut{Input}{Input}\SetKwInOut{Output}{Output}
\Input {$M$-dimensional data set $\mathbf{X} = {\mathbf{x}_1, …, \mathbf{x}_N}$, number of dimensions to reduce to $\widetilde{M}$, perplexity $perp$, number of iterations $T$, learning rate $\eta$, momentum $\alpha (t)$.
}
\Output {$\widetilde{M}$-dimensional representation $\mathbf{Y}$ of $\mathbf{X}$.}
\DontPrintSemicolon
\BlankLine
    \ForEach {$\mathbf{x}_i \in \mathbf{X}$ \do} {
        using vantage-point trees, find KNN $\mathcal{N}_K(\mathbf{x}_i)$ with $K = \lfloor 3 \ perp \rfloor$

        compute symmetric pairwise affinities $p_{ij}$ for all $\mathbf{x}_j \in \mathcal{N}_K(\mathbf{x}_i)$
    }
    
    sample initial low-dimensional representation $\mathbf{Y}^{(0)} = {\mathbf{y}_1, …, \mathbf{y}_n}$ from $\mathcal{N}(0, 10^{-4} I)$

    \For{$t=1$ to $T$ \do}{
        calculate low-dimensional affinities $q_{ij}$ of $\mathbf{Y}^{(t)}$ using the Barnes-Hut algorithm
        
        compute gradient $\frac{\delta \mathcal{C}}{\delta \mathbf{Y}}$ with these $q_{ij}$
        
        $\mathbf{Y}^{(t)} \gets \mathbf{Y}^{(t-1)} + \eta \frac{\delta \mathcal{C}}{\delta \mathbf{Y}} + \alpha (t)(\mathbf{Y}^{(t-1)}-\mathbf{Y}^{(t-2)})$
    }
\caption{(Barnes-Hut) t-Distributed Stochastic Neighbor Embedding}
\end{algorithm}

Both tree data structures, the vantage-point tree and the quadtree used by the Barnes-Hut algorithm, and the sparse representation, to store the $p_{ij}$ in, require $\mathcal{O}(N)$ storage.
This is therefore also the overall storage requirement of Barnes-Hut t-SNE.
This is an improvement over the original t-SNE algorithm, which had a space complexity of $\mathcal{O}(N^2)$, required to store all probability distributions $p_{ij}$.

The time complexity of Barnes-Hut similarly improved from the original $\mathcal{O}(N^2)$ to $\mathcal{O}(N \cdot \log(N))$.
All operations on trees are either $\mathcal{O}(1)$ or $\mathcal{O}(\log(N))$ and thus result in a combined complexity of $\mathcal{O}(N \cdot \log(N))$ when repeated for all of the $N$ input data points.
Other factors, such as the dimensionality $M$ and the number of iterations $T$, can be considered part of the input size $N$ or a constant factor respectively, and are not considered in the runtime complexity of t-SNE.

Parallelizations of t-SNE are commonly in use.
Besides the GPU parallelizations covered in the [related works Section 1.2](#relatedworks), there are also parallel CPU implementations.
The best performing one is Multicore t-SNE [@Ulyanov2016], an adoption of the source code released alongside the original Barnes-Hut t-SNE publication [^bhtsne_code].
The repository states, that the biggest speedup can be made through the parallelization of the KNN search.
In general parallelizing the used algorithms, KNN search and Barnes-Hut, is a key aspect.

<!-- bad performance for embedding bigger than 3D-->
<!-- p_ij symmetric-->

### UMAP {#umap}
Uniform Manifold Approximation and Projection, or UMAP for short, was introduced in 2018 by McInnes et al. [@umap].
The algorithm was inspired by [t-SNE](#tsne), as stated in [@umap-talk-pydata] (minute 16:35).
The intention was to create a similar dimensionality reduction algorithm that is based on a mathematical foundation.
As UMAP was introduced as late as 2018, no secondary literature is available at the time of writing.
The primary resources on UMAP, besides the publication itself, are the source code repository[^code_umap] and a talk of McInnes on the matter [@umap-talk-pydata].

Most prominently the publication shows that UMAP delivers graphical results as good or better than those of t-SNE, while performing faster.
But it also has further improvements over t-SNE:

* UMAP is "viable as a general purpose dimension reduction technique"[@umap], so it can be used for more than just visualization.
t-SNE performs badly when reducing to more than two or three dimensions, due to the spatial data structures it uses.

* UMAP allows for the usage of user-defined metrics with which the input data is interpreted.

* UMAP can add additional data to a previously created low-dimensional representation.

The detailed math and derivation of the algorithm will not be discussed here, since it is of no interest to this thesis' goals.
Instead an analysis of the performed steps and the necessary computations will be done.
The primary focus is on explaining how the mathematical concepts are implemented, so that the analysis of their parallelization in the [following chapter](#methods) is comprehensible.

Conceptually UMAP takes a similar approach to dimensionality reduction as t-SNE.
It first creates an abstract model of the given data $\mathbf{X}$.
Then it initializes an $\widetilde{M}$-dimensional representation $\mathbf{Y}$.
Now $\mathbf{Y}$ is iteratively shaped according to the abstract model of $\mathbf{X}$.
Eventually $\mathbf{Y}$ will be a good low-dimensional representation of $\mathbf{X}$, that not only preserves the local structure, but also separates unlike data points, creating clusters thereby.

Rather then using a probability distribution like t-SNE, UMAP uses a weighted graph as its abstract model.
The motivation as well as the justification for this stems from the mathematical background of UMAP.
Summarized, the publication shows that the structure of the input data can be captured by a simplicial complex, if the data's manifold is approximated via a local connectivity assumption.
In other words, when creating a cover of the data via nearest-neighbor relations, the data's topology is represented independent of the $N$-dimensional space in which it is embedded.

The simplicial complex can hereby be thought of as a graph.
It actually is a set of connected simplices, but only 0-simplices and 1-simplices are considered.
Since a 0-simplex is simply a representation of a data point and a 1-simplex is a connection between two 0-simplices, they are equivalent to nodes and edges of a graph.
For easier comprehensibility the upcoming algorithm description will therefore simply refer to the simplicial complex as a graph.

UMAP starts by performing a KNN search on the input data $\mathbf{X}$.
A graph $\mathcal{G} = (\mathcal{V}, \mathcal{E})$ is created, each data point $\mathbf{x}_i \in \mathbf{X}$ is represented by a node $v_i \in \mathcal{V}$.
For each of the $K$ found nearest-neighbors an edge $e$ between the respective $v_i$ and $v_j$ is inserted in $\mathcal{E}$.
$e$ is assigned a weight $w_{i,j} = \overline{dist}(\mathbf{x}_i, \mathbf{x}_j)$, which can be considered a measure as to how important the edge is.
<!--weight of edge = probability that edge exists-->
<!--combined probability is at least one edge exists probability 1 + probability 2 - probability1*probability2-->

The function $\overline{dist}$ hereby normalizes the distance between two points $\mathbf{x}_i$ and $\mathbf{x}_j$ according to the distance of $\mathbf{x}_i$ to its closest neighbor.
It is locally normalized in a way that the sum $\sum_{e = (v_i, _) \in \mathcal{E}} weight(e)$ over all edge weights is the same for each node.
This assures that the contribution of each node to the structure of the graph is the same, a constraint that is necessary for the mathematical background to hold.
@fig:umap_radii gives an intuition on the involved distance functions and why they need to be normalized individually per node.
@fig:umap_curse shows how such a locally normalized distance function can help overcome the curse of dimensionality.

<div id="fig:umap_radii" caption="abc." class="subfigures">
![Visualization of the distances created by UMAP through a KNN search. The distance to the first node of the KNN is shown as the radius of a plain circle. The distances to the remaining KNN are of descending importance, visualized by a blur surrounding the nodes. Graphic taken from [@umap-talk-pydata] (minute 11:11).](figures/chapter2/umap_balls.png){width=49% #fig:umap_radii_a}\hfill
![The graph created from the locally normalized distances. The line thickness visualizes the weight of edges. Due to the normalization areas with few data points, such as the center in this example, are still well captured and strongly connected. Graphic taken from [@umap-talk-pydata] (minute 16:35).](figures/chapter2/umap_graph.png){width=49% #fig:umap_radii_b}

Exemplary graph created by UMAP for data lying on a sine wave manifold.
</div>
<div id="fig:umap_curse" class="subfigures">
![Distances to 20 nearest-neighbors of data randomly sampled from a normal distribution. Graphic taken from [@umap-talk-pydata] (minute 11:30).](figures/chapter2/umap_dim_1.png){width=33% #fig:umap_curse_a}\hfill
![The same distances, normalized. All high-dimensional data points have appropriately the same distance from one another. This is also known as the curse of dimensionality. Graphic taken from [@umap-talk-pydata] (minute 11:50).](figures/chapter2/umap_dim_2.png){width=33% #fig:umap_curse_b}\hfill
![The same distances, normalized by local connectivity as in @fig:umap_radii_a. The result is a normal distance distribution, independent of the number of dimensions. Graphic taken from [@umap-talk-pydata] (minute 12:10).](figures/chapter2/umap_dim_3.png){width=33% #fig:umap_curse_c}

Overcoming the curse of dimensionality with locally normalized distances.
</div>

$\mathcal{G}$ is now used to initialize the $\widetilde{M}$-dimensional representation $\mathbf{Y}$.
It is created by calculating the eigenvectors of the adjacency matrix for $\mathcal{G}$.
The $\widetilde{M}$ eigenvectors with the highest eigenvalues form $\mathbf{Y}$.

\pagebreak

With this initial low-dimensional representation $\mathbf{Y}$ in place, UMAP proceeds to improve $\mathbf{Y}$.
Using a stochastic gradient descent (SGD) technique the points $\mathbf{y}_i \in \mathbf{Y}$ are repositioned over the course of $T$ iterations.
The function to minimize is $\Phi(\mathbf{y}_i,\mathbf{y}_j) = (1+a(\|\mathbf{y}_i-\mathbf{y}_j\|_2^2)^b)^{-1}$.
$a$ and $b$ are hereby precomputed constants, chosen to define a differentiable function.
The gradient along $\Phi$ is used to update $\mathbf{y}_i$.
For each edge $(v_i, v_j) \in \mathcal{E}$ an update is performed, so that $\mathbf{y}_i \gets \mathbf{y}_i + \alpha \cdot \nabla(log(\Phi))(\mathbf{y}_i, \mathbf{y}_j)$ where $\alpha$ is a scaling factor that decreases proportional to the amount of passed iterations.

Since a SGD and not a normal gradient descent procedure is used, such updates are not performed for all edges in each iteration.
The edges are sampled by only considering them for an update with a certain likelihood.
The weight of the edge determines the probability with which it is sampled.
In the case that it is sampled an additional negative sampling step is also performed.
For that, a set of randomly selected points $Neg$ is used to additionally reposition $\mathbf{y}_i \gets \mathbf{y}_i + \alpha \cdot \nabla(1-log(\Phi))(\mathbf{y}_i, \mathbf{y}_k)$ where $\mathbf{y}_k \in Neg$.

While the regular SGD step is meant to correctly position $\mathbf{y}_i$ and $\mathbf{y}_j$ in relation to each other, the negative sampling step increases the distance between unrelated data points.
Thus, the regular step draws related points closer together, which forms clusters in the low-dimensional representation, whereas the negative sampling step pushes points further away from each other, creating gaps in between these clusters.
This spreading out of the data is one of the reasons for UMAP's improved graphical results when used for visualization, since it preserves the global structure of the original data.

\pagebreak
\pagebreak

\begin{algorithm}[H]
\label{umap_algo}
\SetKwInOut{Input}{Input}\SetKwInOut{Output}{Output}
\SetKwRepeat{Do}{do}{while}
\Input{$M$-dimensional data set $\mathbf{X} = {\mathbf{x}_1, …, \mathbf{x}_N}$, number of dimensions to reduce to $\widetilde{M}$, number of neighbors to consider $K$, number of iterations $T$.}
\Output {$\widetilde{M}$-dimensional representation $\mathbf{Y}$ of $\mathbf{X}$.}
\DontPrintSemicolon
\BlankLine
    Initialize graph $\mathcal{G} = (\mathcal{V}, \mathcal{E})$ with $\mathcal{V} = v_1, …, v_N$ and $\mathcal{E} = \emptyset$

    \ForEach{$\mathbf{x}_i \in \mathbf{X}$ \do}{
        find KNN $\mathcal{N}_K(\mathbf{x}_i)$
        
        \ForEach{$\mathbf{x}_j \in \mathcal{N}_K(\mathbf{x}_i)$ \do}{
            $w_{i,j} \gets \overline{dist}(\mathbf{x}_i, \mathbf{x}_j)$, where $\overline{dist}$ is the locally normalized distance
            
            $\mathcal{E} \gets \mathcal{E} \cup e = (v_i, v_j)$ with $weight(e) = w_{i,j}$
        }
    }
    
    initialize $\mathbf{Y} = {\mathbf{y}_1, …, \mathbf{y}_N}$ with $\widetilde{M}$ eigenvectors from the adjacency matrix of $\mathcal{G}$

    \For{$n=1$ to $T$ \do}{
        \ForEach{$e = (i,j) \in E$ \do}{
            \If{$weight(e) > r$, where $r \in (0,1)$  is a random value}{
                use gradient-descent to reposition $\mathbf{y}_i$ with respect to \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \  a) $\mathbf{y}_j$, the representation of $e$'s other node, and \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ b) a set of randomly selected points for negative sampling
            }
        }
    }
\caption{Uniform Manifold Approximation and Projection}
\end{algorithm}

The used KNN search algorithm, NN-Descent, is an approximate KNN algorithm with a stated "empirical complexity of $\mathcal{O}((N \cdot M)^{1.14})$" [@Dong2011].
The stochastic gradient descent with the negative sampling has a time complexity of $\mathcal{O}(K \cdot N)$".
Since $K \ll N$ the total time complexity is bound by the KNN search.
Analogous to the time complexity of t-SNE, the amount of iterations $T$ is considered a constant.
The space complexity of UMAP can be dominated by either the graph structure or the low-dimensional representation, depending on whether $\widetilde{M}$ or $K$ is bigger.
It therefore is $\mathcal{O}((K + \widetilde{M}) \cdot N)$.

An analysis of how UMAP can be parallelized is given in [Chapter 3](#methods).

### Visual Results
To compare the visualization results of the aforementioned dimensionality reduction algorithms, @fig:viz_compare shows visualizations for several data sets.
The MNIST data set [@mnist], is commonly used for assessing the visualization quality of dimensionality reduction algorithms.
By reference to it, it can be seen that the quality of PCA's visualization is inferior to those of t-SNE and UMAP.
The points in the graphical output of PCA are merely spread out, while t-SNE and UMAP both show clearly recognizable clusters.
The colors representing the labels of the data set show that the clusters are correctly formed and consist of similar data.
The differences between t-SNE and UMAP are not quite as grave, but nonetheless very noticeable.
The clusters formed by t-SNE are closer together with more noise in between and not as dense as those created by UMAP.
Additionally UMAP produces no split up clusters as in the lower part of t-SNE's visualization.

![Visualizations of various data sets by PCA, t-SNE and UMAP. The figure is modified from the UMAP publication [@umap], Figure 2.](figures/chapter2/modified_umap_graphic.png){#fig:viz_compare short-caption="Visualizations of data sets by PCA, t-SNE and UMAP."  width="82%"}




[^openblas_web]: http://www.openblas.net, accessed 20.04.2019
[^bhtsne_code]: https://github.com/lvdmaaten/bhtsne, accessed 20.04.2019
[^code_umap]: https://github.com/lmcinnes/umap, accessed 20.04.2019
