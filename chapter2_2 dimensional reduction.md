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
It creates linear transformation of the data by constructing 
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
\Input{data $\mathcal{X} = {x_1, x_2, …, x_n}$ with $d$ dimensions,

    \ \ \ \ \ \ \ \ \ \ \ \ \ dimensions to reduce to $k$. }
\DontPrintSemicolon
\BlankLine

    compute the covariance matrix of $\mathcal{X}$
    
    compute the eigenvectors ${e_1, e_2, …, e_d}$ with the corresponding eigenvalues ${\lambda_1, \lambda_2, …, \lambda_d}$
    
    sort the eigenvectors by decreasing eigenvalues
    
    create a $d x k$ matrix $W$ with the first $k$ eigenvectors

    calculate a low-dimensional representation $\mathcal{Y} = W × \mathcal{X}$

\caption{Principal Components Analysis}
\end{algorithm}

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
Thus, a way to measure how good a low-dimensional representation is, is needed.
For this t-SNE uses the Kullback-Leibler divergence $f_{KL}()$.
From both, the original data $\mathcal{X} = {x_1, x_2, …, x_N}$ and the low-dimensional representation $\mathcal{Y} = {y_1, y_2, …, y_N}$, probability distributions are determined.
They are calculated based on a distance function $dist()$, so that they can capture the layout of the data.
The algorithm uses the Euclidean metric, but any other distance function, that can be applied between data points, can be used too.
Data points that have a small distance from one another are assigned a high probability, while those further apart from each other receive a low probability.
Every pair of data points, $x_i$ and $y_i$, has two probability distributions.
$P_i$, the probability distribution in the original data, describing what points are likely to be close to $x_i$, and $Q_i$, the probability distribution in the low-dimensional representation, analogously describing points close to $y_i$.

Using the Kullback-Leibler divergences of probability distributions pairs $P_i$ and $Q_i$, the quality of a low-dimensional representation can be assessed.
A cost function $C = \sum{f_{KL}(P_i||Q_i)}$ can be formulated to obtain a minimization problem.
In other words, the lower the sum over all Kullback-Leibler divergences, the better the found representation.

The gradient $\dfrac{\delta \mathcal{C}}{\delta \mathcal{Y}}$ of this sum can be used to achieve a better low-dimensional representation.
Using a learning rate parameter $\eta$ and a time-dependent momentum parameter $\alpha(t)$, t-SNE improves its low-dimensional representation with a gradient decent procedure according to the formular $\mathcal{Y}^{(t)} = \mathcal{Y}^{(t-1)} + \eta \dfrac{\delta \mathcal{C}}{\delta \mathcal{Y}} + \alpha (t)(\mathcal{Y}^{(t-1)}-\mathcal{Y}^{(t-2)})$.

The two big improvements made by the Barnes-Hut variant are a) neglecting of infinitesimal probabilities when calculating probability distributions $P_i$; and b) summarizing similar probabilities when calculating $Q_i$, to speed up the gradient calculation.
Both speedups are achieved by using tree data structures:

Through the usage of a vantage-point tree, as introduced in [@Yianilos1993], a k-Nearest-Neighbor (kNN) search is performed.
<!-- by using a depth-first search.-->
Only the found nearest-neighbors are considered for calculating the distances upon which the $P_i$ probability distributions are based.
With the found nearest-neighbors a sparse representation of the probability distributions $P_i$ is created.
The k parameter of kNN is provided by using a multiple of the user-defined perplexity input parameter.
"The perplexity [parameter] can be interpreted as a smooth measure of the effective number of neighbors.", as is stated in [@tsne]. [^note_perplexity]


The low-dimensional representation $\mathcal{Y}$ is initialized randomly.
Through the gradient descent procedure described above, $\mathcal{Y}$ is shaped to better represent $\mathcal{X}$.
The probability distributions $Q_i$, upon which this procedure builds, consist of a lot of insignificantly small probabilities, resulting from points that have a high distance from each other.
These probabilities contribute very little to the gradient $\dfrac{\delta \mathcal{C}}{\delta \mathcal{Y}}$.
Creating a sparse representation, as done for the $P_i$ probability distributions, causes unnecessary overhead, since the $Q_i$ probabilities are only used once and need to be recalculated for each iteration of the gradient descent procedure.

Therefore, Van der Maaten et al. utilize the Barnes-Hut algorithm [@Barnes1986].
It creates a spatial tree, e.g. a quad tree for two dimensional space, and uses them to summarize distances between data points that a far apart.
If a point has approximately the same distance to a group of other points, this point group will be considered as one, using the points' average position to calculate the distance.
The average is pre-calculated for each space partition in the tree and does not cause overhead per calculation.
Calculating the distances between all points can hereby be sped up, since fewer calculations are needed.
@fig:barnes_hut shows an example of how data points are grouped with the tree structure.

![The quadtree structure shown on the left side is used by the Barnes-Hut algorithm to group data points as shown on the right side. Distances from the starting point, the x mark, can so be calculated faster. The graphic is taking from  [@Barnes1986], figure 1.](figures/chapter2/barnes_hut.png){#fig:barnes_hut short-caption="Tree structure used by the Barnes-Hut algorithm."  width="60%"}



This results in a linear storage requirement.

\begin{algorithm}[H]
\label{pca_algo}
\SetKwInOut{Input}{Input}\SetKwInOut{Output}{Output}
\Input {data set $\mathcal{X} = {x_1, x_2, …, x_N}$,
                
    \ \ \ \ \ \ \ \ \ \ \ \ \ cost function parameters: perplexity $\mathcal{u}$,
    
    \ \ \ \ \ \ \ \ \ \ \ \ \ optimization parameters: number of iterations $T$ , learning rate $\eta$, momentum $\alpha (t)$.
}
\Output {low-dimensional data representation $\mathcal{Y}^{(T)} = {y_1, y_2, …, y_n }$.}
\DontPrintSemicolon
\BlankLine
    find set $\mathcal{N}_i$ of n-nearest neighbors for each input object
    
    compute symmetric pairwise affinities $p_{ij}$, for corresponding objects in $\mathcal{N}_i$
    
    sample initial solution $\mathcal{Y}^{(0)} = {y_1 , y_2 , ., y_n}$ from $\mathcal{N}(0, 10^{-4} I)$

    \For{$t=1$ to  $T$ \do}{
        construct Barnes-Hut tree of $\mathcal{Y}^{(t)}$
        
        compute gradient $\dfrac{\delta \mathcal{C}}{\delta \mathcal{Y}}$ with Barnes-Hut tree using low-dimensional affinities $q_{ij}$
        
        set $\mathcal{Y}^{(t)} = \mathcal{Y}^{(t-1)} + \eta \dfrac{\delta \mathcal{C}}{\delta \mathcal{Y}} + \alpha (t)(\mathcal{Y}^{(t-1)}-\mathcal{Y}^{(t-2)})$
    }
\caption{Simple version of (Barnes-Hut) t-Distributed Stochastic Neighbor Embedding.}
\end{algorithm}

<!--    compute pairwise affinities $p_{j|i}$-->
<!-- set $p_{ij} = \dfrac{p_{j|i} +  p_{i|j}}{2n}$-->

 in a two or three dimensional space.

only 2D or 3D embeddings
otherwise bad performance
yielding from the Barnes-Hut tree structure
spatial 


It reduces the theoretical runtime from the previous $\mathcal{O}(N^2)$ to $\mathcal{O}(N \log(N))$.


<!-- is an dimension reduction algorithm that maps data points with high dimensional complexity to lower dimensional representations. It tries to preserve locality in between the points while doing so.-->

<!--O(N log(N)), O(N) Speicher-->

<!--This allows for a theoretical and practical speed-up of the algorithm.-->



### UMAP {#umap}
Uniform Manifold Approximation and Projection, or UMAP for short, was introduced in 2018 by McInnes et al. [@umap].
The algorithm was inspired by [t-SNE](#tsne), as stated in [@umap-talk-pydata], minute 16:35.
The intention was to create a similar dimensionality reduction algorithm that is based on a mathematical foundation.
As UMAP was introduced as late as 2018, no literature is available at the time of writing.
The primary resources on UMAP, besides the publication itself, are the source code [repository](https://github.com/lmcinnes/umap/) and several talks of McInnes on the matter.

The math behind the algorithm will be not be discussed in detail here, since it is of no interest to this thesis' goals.
Instead a broad outline will suffice.
The primary focus is on explaining how the mathematical concepts are used, so that the analysis of their parallelization in the [following chapter](#methods-umap) is comprehensible.


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

[^note_perplexity]: However, the perplexity parameter has not been used for a kNN search in the original publication. Instead it was only used to normalize the found probability distributions $P_i$, which is also still the case for the Barnes-Hut version.
