## Dimensionality Reduction Algorithms
Visualization of data with few dimensions can be achieved through traditional visualization methods, such as those seen in @fig:low_dim_visualizations.
But for data with hundreds or thousands of dimensions these methods can not effectively be applied.
Such high-dimensional data is common in fields as genomics, medicine and machine learning.
Exploratory data analysis is important in these fields, therefore a way to visualize the data is desirable.

Dimensionality reduction algorithms provide a solution.
They create low-dimensional representations of high-dimensional data.
In general this can be useful for a multitude of applications, however, this thesis only takes interest in using dimensionality reduction algorithms as means of visualization.

In the following sections the commonly used algorithms PCA and t-SNE will be covered.
Furthermore the central algorithm of the thesis, UMAP, will be introduced.
PCA is a linear transformation, that preserves the global structure of its input data, whereas t-SNE and UMAP are non-linear dimensionality reduction methods, that preserve global and local structure of their input data alike.
To highlight the difference between the graphical results of the algorithms, a comparison of them is given as a conclusion to the chapter.

### PCA
One of the most commonly used dimensionality reduction algorithms is Principal Components Analysis (PCA).
Its origins "are often difficult to trace" according to [@Jolliffe2002], but are generally agreed upon to lay within the beginning of the 20th century.
Throughout history PCA has been discovered multiple times, which is an indicator of how fundamental the algorithm is.
It is a versatile algorithm with multiple applications, that is still frequently referenced and used in current research publications.
A common application in the field of data analysis is that of visualizing data.

<!--What PCA does-->
PCA is a statistical method to reduce data dimensionality.
It creates a linear transformation of the data utilizing the data's variance.
In simple terms, PCA finds a vector

TODO

 is found, which, when projecting the data onto it, 

expansion

causes the data to be as spread out as possible
Finding a vector in the high-dimensional space that yieldy the highest

The $M$-dimensional input data $\mathcal{X} = {x_1, …, x_N}$ is treated as a $M \times N$ matrix.

Through calculating the covariance matrix $K_X$
constructing 
transform high-dimensional data into a lower extract information on data's highest variance.

matrix factorization
linear
global not local
 
orthogonal vectors

pre processing for other algorithms

V directions of maximum variance
orthogonal to each other

project points onto V vectors
U values of projected points

matrix factorisation


either minimize distance to projection point
or maximize variance on projection




\begin{algorithm}[H]
\label{pca_algo}
\SetKwInOut{Input}{Input}\SetKwInOut{Output}{Output}
\SetKwRepeat{Do}{do}{while}
\Input{$M$-dimensional data set $\mathcal{X} = {x_1, …, x_N}$, in $N \times M$ matrix form,

\ \ \ \ \ \ \ \ \ \ \ \ \ number of dimensions to reduce to $\bar{N}$. }
\Output {A $\bar{N}$-dimensional representation $\mathcal{T}$ of $\mathcal{X}$}
\DontPrintSemicolon
\BlankLine
    obtain $\tilde{\mathcal{X}}$ by centering $\mathcal{X}$ through subtracting the mean in each dimension

    calculate the covariance matrix $\mathcal{C} = \dfrac{1}{N-1} \tilde{\mathcal{X}}^T \times \tilde{\mathcal{X}}$
    
    diagonalize $\mathcal{C}$ to compute the eigenvectors and their responding eigenvalues $\mathcal{E} = {(\bar{e_1}, \lambda_1), …, (\bar{e_N}, \lambda_N)}$
    
    sort $\mathcal{E}$ by decreasing eigenvalue
    
    create a $M \times \bar{N}$-dimensional matrix $\mathcal{W}$ using the first $\bar{N}$ eigenvectors of $\mathcal{E}$

    calculate the low-dimensional representation $\mathcal{T} = \mathcal{W} \times \mathcal{X}$
\caption{Principal Components Analysis}
\end{algorithm}

The time complexity of the described PCA variant is $\mathcal{O}(N^3)$, due to the 

In practice the covariance method is not used due to this high time complexity.
Instead variants that don't compute the 
ons  it
scaling 

transforming by mean vector to center





<!--supervised-->
<!--block-->
<!--2-3 Formeln-->
<!--bsp. der dimensionsreduktion-->



### t-SNE {#tsne}
t-SNE is the state of the art dimensionality reduction algorithm for visualizing high-dimensional data.
It was introduced by Van der Maaten et al. in 2008 [@tsne].
The name is derived from Stochastic Neighbor Embedding (SNE) [@sne], of which t-SNE is a variation.
The t stems from its usage of the Student's t-distribution, one of several modifications introduced by t-SNE.

<!--good graphics-->
The publication shows that t-SNE's graphical results surpass those of other related algorithms available at the time of publication.
@fig:coil20_tsne provides an example for this, a comparison between visualizations on the basis of the COIL-20 data set [@coil20].
The COIL-20 data set is composed of picture series from 20 different objects, each photographed from 72 equidistant angles by a camera orbiting the object.
As can be seen, t-SNE captures the circular nature of the data well.
It correctly represents the data of several objects as closed loops, while the algorithms used for comparison can at best display the data in a curved form.

![Visualizations of the COIL-20 data set [@coil20] by t-SNE, Sammon mapping, Isomap and LLE. The graphic is taking from  [@tsne], figure 5.](figures/chapter2/coil20_tsne.png){#fig:coil20_tsne short-caption="Visualizations of the COIL-20 data set."  width="80%"}

<!--bhtsne-->
In 2014 a refined version, Barnes-Hut t-SNE, was published by van der Maaten [@bhtsne].
It reduces the runtime of the algorithm significantly, while providing the same quality of graphical output.
Since there are no real differences for users of the algorithm, the Barnes-Hut version is commonly referred to by simply t-SNE.
To keep its terminology aligned, this thesis does the same.
The following algorithm description also focuses on the refined version, while still describing the differences between the two.

The basic concept of t-SNE is to find a low-dimensional representation of the input data, that preserves the structure of the input data as well as possible.
Thus, a way to measure the quality of such a low-dimensional representation is needed.
For this t-SNE uses the Kullback-Leibler divergence $f_{KL}()$.
From both, the original data $\mathcal{X} = {x_1, …, x_N}$ and the low-dimensional representation $\mathcal{Y} = {y_1, …, y_N}$, probability distributions are determined.
These probabilities distributions describe the affinities between all points in the respective data.
$P=(p_{ij})$ contains all affinities of points $x_i, x_j \in \mathcal{X}$, $Q=(q_{ij})$ all of $y_i, y_j \in \mathcal{Y}$.

$P$ and $Q$ are calculated based on a distance function $dist()$, to capture the layout of the data.
By default t-SNE uses the Euclidean metric, but any other distance function can be used too.
Data points that have a short distance from one another are assigned a high affinity, while those further apart from each other receive a low affinity.

In the same manner that every point $x_i \in \mathcal{X}$ has a low-dimensional representation $y_i \in \mathcal{Y}$, every $p_{ij}$ responds to a $q_{ij}$.
Comparing $p_{ij}$ with $q_{ij}$ shows how well the affinity between $x_i$ and $x_j$ is preserved by their low-dimensional counterparts $y_i$ and $y_j$.
This comparison is done with the Kullback-Leibler divergence.
Using it on all pairs of $p_{ij} \in P$ and $q_{ij} \in Q$, the quality of the low-dimensional representation is assessed.
As a consequence a cost function $C = f_{KL}(P||Q) = \sum\limits_i \sum\limits_j p_{ij} \log{\frac{p_{ij}}{q_{ij}}}$ can be formulated.
The lower the Kullback-Leibler divergence between the probability distribution, the better the found representation $\mathcal{Y}$.

t-SNE minimizes $C$ by using the gradients $\frac{\delta \mathcal{C}}{\delta y_i}$.
Each gradient describes how $C$ changes in relation to the respective $y_i$.
Using a learning rate parameter $\eta$ and a time-dependent momentum parameter $\alpha(t)$, t-SNE improves $\mathcal{Y}$ with a gradient decent procedure, according to the formula $\mathcal{Y}^{(t)} = \mathcal{Y}^{(t-1)} + \eta \frac{\delta \mathcal{C}}{\delta \mathcal{Y}} + \alpha (t)(\mathcal{Y}^{(t-1)}-\mathcal{Y}^{(t-2)})$.

This fundamental approach of t-SNE is the same for both, the original and the Barnes-Hut variant.
The two big improvements made by the Barnes-Hut variant are a) neglecting of infinitesimal probabilities when calculating the probability distributions $p_{ij}$ and b) summarizing similar probabilities distributions when calculating $q_{ij}$, to speed up the gradient calculation.
Both are achieved by using tree data structures:

Through the usage of a vantage-point tree, as introduced in [@Yianilos1993], a $K$-Nearest-Neighbors (KNN) search is performed.
For each point $x_{i}$ only the $K$ found nearest-neighbors $\mathcal{N}_K(x_i)$ are used to calculate the probability distributions.
All other probability distributions with $x_j \notin \mathcal{N}_K(x_i)$ are ignored by defining $p_{ij} = 0$.
These nulled affinities can be omitted when storing $P$ by using a sparse data structure, reducing the otherwise needed $\mathcal{O}(N^2)$ space complexity to a linear $\mathcal{O}(N)$.

The $K$ parameter of the KNN search is provided by using a multiple of the user-defined perplexity input parameter $perp$.
"The perplexity can be interpreted as a smooth measure of the effective number of neighbors.", as is stated in [@tsne].
So the choice of $perp$ should be made based on the amount of neighbors that a data point is expected to have on average, "typical values are between 5 and 50".
The perplexity parameter has not been used for a KNN search in the original publication.
Instead it was only used to normalize the probability distributions of $P$.
In the Barnes-Hut variant it is still used for this, but, to simplify the algorithm description, further details on the perplexity are omitted.

The low-dimensional representation $\mathcal{Y}$ is initialized randomly.
Through the gradient descent procedure described above, $\mathcal{Y}$ is shaped to better represent $\mathcal{X}$.
A majority of the probability distributions $q_{ij}$, upon which this procedure builds, are small, resulting from many points having a big distance from one another.
Individually these $q_{ij}$ contribute very little to the gradient $\frac{\delta \mathcal{C}}{\delta \mathcal{Y}}$.
It is desirable not to calculate all of them, in order to accelerate the algorithm.
However, while they are negligible on their own, the amount of such $q_{ij}$ is too high to discount all.

Therefore, t-SNE utilizes the Barnes-Hut algorithm [@Barnes1986].
It creates a spatial tree, e.g. a quad tree for two dimensional space, and uses it to summarize distances between data points that a far apart.
If a point has approximately the same distance to a group of other points, this group will be treated as a single point, using the average of the group's positions to calculate the distance.
This average is pre-calculated for each space partition in the tree and does not cause overhead per query.
@fig:barnes_hut shows an example of how data points are grouped with the tree structure.
Calculating the distances between all points can hereby be sped up, since fewer calculations are needed.

![The quadtree structure shown on the left side is used by the Barnes-Hut algorithm to group data points as shown on the right side. Distances from the starting point, the x mark, can so be calculated faster. The graphic is taking from  [@Barnes1986], figure 1.](figures/chapter2/barnes_hut.png){#fig:barnes_hut short-caption="Tree structure used by the Barnes-Hut algorithm."  width="60%"}

An outline of t-SNE can be seen in the following Algorithm \autoref{tsne_algo}.

\begin{algorithm}[H]
\label{tsne_algo}
\SetKwInOut{Input}{Input}\SetKwInOut{Output}{Output}
\Input {$M$-dimensional data set $\mathcal{X} = {x_1, …, x_N}$,

\ \ \ \ \ \ \ \ \ \ \ \ \ number $\bar{N}$ of dimensions to reduce to, perplexity $perp$,

\ \ \ \ \ \ \ \ \ \ \ \ \ number of iterations $T$, learning rate $\eta$, momentum $\alpha (t)$.
}
\Output {low-dimensional data representation $\mathcal{Y}^{(T)} = {y_1, …, y_n}$.}
\DontPrintSemicolon
\BlankLine
    \ForEach {$x_i \in \mathcal{X}$} {
        using vantage-point trees, find KNN $\mathcal{N}_K(x_i)$ with $K = \lfloor 3 \ perp \rfloor$
    }
    
    compute symmetric pairwise affinities $p_{ij}$ for all $x_j \in \mathcal{N}_K(x_i)$
    
    sample initial low-dimensional representation $\mathcal{Y}^{(0)} = {y_1, …, y_n}$ from $\mathcal{N}(0, 10^{-4} I)$

    \For{$t=1$ to  $T$ \do}{
        construct quadtree of $\mathcal{Y}^{(t)}$
        
        compute gradient $\dfrac{\delta \mathcal{C}}{\delta \mathcal{Y}}$, calculating low-dimensional affinities $q_{ij}$ with the Barnes-Hut algorithm 
        
        set $\mathcal{Y}^{(t)} = \mathcal{Y}^{(t-1)} + \eta \dfrac{\delta \mathcal{C}}{\delta \mathcal{Y}} + \alpha (t)(\mathcal{Y}^{(t-1)}-\mathcal{Y}^{(t-2)})$
    }
\caption{(Barnes-Hut) t-Distributed Stochastic Neighbor Embedding.}
\end{algorithm}

Both tree data structures, the vantage-point tree and the quadtree used by the Barnes-Hut algorithm, and the sparse representation, to store the $p_{ij}$ in, require $\mathcal{O}(N)$ storage.
This is therefore also the overall storage requirement of Barnes-Hut t-SNE.
An improvement over the original t-SNE algorithm, which had a space complexity of $\mathcal{O}(N^2)$, required to store all probability distributions $p_{ij}$.

The time complexity of Barnes-Hut similarly improved from the original $\mathcal{O}(N^2)$ to a $\mathcal{O}(N \log{N})$.
All operations on trees are either $\mathcal{O}(1)$ or $\mathcal{O}(\log{N})$ and thus result in a combined complexity of $\mathcal{O}(N \log{N})$ when repeated for all of the $N$ input data points.
Other factors, such as the dimensionality $M$ and the number of iterations $T$, can be considered part of the input size $N$ or a constant factor respectively, and thus are not considered to describe the runtime of t-SNE.

Parallelizations of t-SNE are commonly in use.
Besides the GPU parallelizations covered in the [related works section  1.2](#relatedworks), there are also parallel CPU implementations.
The best performing one is Multicore t-SNE [@Ulyanov2016], an adoption of the source code released alongside the original Barnes-Hut t-SNE publication [^bhtsne_code].
The repository states, that the biggest speedup can be made through the parallelization of the KNN search.
In general the parallelization of t-SNE is dependent on parallelizing the used algorithms, KNN search and the Barnes-Hut algorithm.

### UMAP {#umap}
Uniform Manifold Approximation and Projection, or UMAP for short, was introduced in 2018 by McInnes et al. [@umap].
The algorithm was inspired by [t-SNE](#tsne), as stated in [@umap-talk-pydata] (minute 16:35).
The intention was to create a similar dimensionality reduction algorithm that is based on a mathematical foundation.
As UMAP was introduced as late as 2018, no secondary literature is available at the time of writing.
The primary resources on UMAP, besides the publication itself, are the source code repository[^code_umap] and a talk of McInnes on the matter.

The detailed math behind the algorithm will be not be discussed in detail here, since it is of no interest to this thesis' goals.
Instead a broad outline will suffice.
The primary focus is on explaining how the mathematical concepts are used, so that the analysis of their parallelization in the [following chapter](#methods-umap) is comprehensible.

Conceptually UMAP takes a similar approach to t-SNE

<!--Uniform Manifold Approximation and Projection, or UMAP for short, is a new dimensionality reduction algorithm, introduced in 2018 by McInnes et. al. [@umap].-->
<!--It is building on mathematical principles of Riemannian geometry and algebraic topology.-->
<!--This ground-up algorithm conception allows for multiple benefits, described in chapter [2.2.3](#umap).-->
<!--However most prominently the paper shows that UMAP delivers graphical results as good or better than those of t-SNE, while performing faster.-->
<!--Since no parallelized version is available as of yet, the paper only compares sequential implementations.-->


\begin{algorithm}[H]
\DontPrintSemicolon 
\SetAlgoLined
\BlankLine
    \For{all x $\in$ X}{
        fs-set[x] $\gets$ LocalFuzzySimplicialSet(X, x, n)
    }
    top-rep $\gets$ x $\in$ X fs-set[x]
    
    Y $\gets$ SpectralEmbedding(top-rep, d)
    
    Y $\gets$ OptimizeEmbedding(top-rep, Y , min-dist, n-epochs)
    
    return Y
\caption{UMAP algorithm.}
\end{algorithm} 

<!--\KwResult{Write here the result}-->
<!--\SetKwInOut{Input}{Input}\SetKwInOut{Output}{Output}-->
<!--\Input{Write here the input}-->
<!--\Output{Write here the output}-->

<!--\While{While condition}{-->
<!--    instructions\;-->
<!--    \eIf{condition}{-->
<!--        instructions1\;-->
<!--        instructions2\;-->
<!--    }{-->
<!--        instructions3\;-->
<!--    }-->
<!--}-->

"The UMAP algorithm is competitive with t-SNE for visualization quality, and arguably preserves more of the global structure with superior run time performance"

"viable as a general purpose dimension reduction technique for machine learning"
multiple metrics

add points to existing embedding

<!--It can be used for other things than just visualization, as it allows for the usage of non-metric distance functions and can efficiently embed data into more than two dimensions.-->
<!--UMAP also supports to map data into an existing embedding, without the need of reapplying the algorithm to the entire data set.-->

combine different metric spaces
turning all into fuzzy simplicial sets

weight of edge = probability that edge exists



<!--Due to the curse of dimensionality most clustering algorithms perform badly on data with high-dimensional complexity.-->


<!-- TODO mention partial update -->

### Visual Results
To compare the visualization results of the aforementioned algorithms, @fig:viz_compare shows visualizations of each algorithm for several data sets.
The MNIST data set [@mnist], shown in the second column, is a commonly used example of assessing the quality of dimensionality reduction algorithms.
By reference to it, 
The figure shows that the quality of PCA is inferior to those of t-SNE and UMAP.
The points in the graphic output of PCA look merely spread out, unlike the visualizations of the other competitors, which both show clearly recognizable clusters.
The labels represented as colors show that the clusters also are correctly formed and consist of similar data.

The differences between t-SNE and UMAP are not quite as grave, but nonetheless very noticeable.
The clusters formed by t-SNE are closer together and not as dense as those created by UMAP.
Additionally UMAP has less noise in between the clusters and shows no split clusters as t-SNE does in the lower part of its visualization.

![Visualizations of data sets by PCA, t-SNE and UMAP. The figure is modified from the UMAP publication [@umap], figure 2.](figures/chapter2/modified_umap_graphic.png){#fig:viz_compare short-caption="Visualizations of data sets by PCA, t-SNE and UMAP."  width="100%"}

[^bhtsne_code]: https://github.com/lvdmaaten/bhtsne, last accessed 20.04.2019
[^code_umap]: https://github.com/lmcinnes/umap, last accessed 20.04.2019
