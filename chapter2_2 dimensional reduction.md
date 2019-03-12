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
PCA is a statistical method to extract information on data's highest variance.

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
t-SNE is a visualization algorithm for high-dimensional data.
It was introduced by Van der Maaten et al. in 2008 [@tsne].
The name is derived from Stochastic Neighbor Embedding (SNE), of which t-SNE is a variation.
The t stems from its usage of the Student's t-distribution.

The publication shows that t-SNE's graphical results surpass those of other related algorithms available at the time.
The results had a clear separation between clusters of similar data, while the algorithms used for comparison displayed big areas of overlap.

In 2014 a refined version, Barnes-Hut t-SNE, was published by van der Maaten [@bhtsne].
It reduces the theoretical runtime from the previous $\mathcal{O}(N^2)$ to $\mathcal{O}(N \log(N))$.
Since there are no real differences for users of the algorithm, the Barnes-Hut version is commonly referred to by simply t-SNE.
To keep its terminology aligned, this thesis does the same.









The basic concept of t-SNE is to find a low dimensional representation of the input data, that preserves the local structure as good as possible.

distances
space-partitioning (metric) trees



The t-SNE algorithm creates a low-dimensional representation of the input data and tries to preserve the original data  structure as well as possible.
It measures 


and comparing it with that of the input data.


The t-SNE algorithm consists of two parts.
First, a k-Nearest-Neighbor (kNN) search is performed.
From it a sparse representation of similarities between data points are created, based upon which data points are close to one another.
In the second part a low-dimensional representation of the original data is initialized.
By measuring the similarities of the low-dimensional representation and comparing it to the similarities of the original input data, the low-dimensional representation is iteratively altered to represent the original well.


<!--to find 3u (perplexity) NN, vantage-point tree, 
The publication builds on the work of Yianilos, 1993
possible with all metrics d()
depth-first search on tree to create -->
The results are used to create a sparse representation of 
similarities


 With , to find the closest points for each to all 
   nearest neighbors of the 
<!--TODO broadly explain t-SNE, introducing kNN-->



t-SNE uses a Barnes-Hut tree to reduce the number of necessary computations between data points.

In a similar manner t-SNE-CUDA only considers relations between a certain amount of nearest-neighbors for each point.

These neighbors are calculated using the approximate k-nearest-neighbors algorithm provided by the FAISS library [@faiss].
The library's algorithm runs on the GPU and outperforms other nearest-neighbor search implementations.

By using a sparse representation, relations that are negligible do not need to be represented.
This results in a linear storage requirement.
For computations on these sparse representations the cuBLAS Library [@cublas] is used.
cuBLAS offers parallelized versions of common BLAS (Basic Linear Algebra Subprograms) operations, such as basic matrix and vector calculations.

Based on the found neighborhoods a Barnes-Hut tree is constructed.
The construction of the tree is adapted from an implementation [@Burtscher2011] of Barnes-Hut trees in CUDA.
This part of the algorithm is analogous to the original algorithm.
All operations are either on the tree or the sparse representations and are executed in parallel on the GPU.




<!--\SetAlgoLined-->
<!--\KwResult{Write here the result}-->
<!--TODO remove line numbering-->
\begin{algorithm}[H]
\label{pca_algo}
\SetKwInOut{Input}{Input}\SetKwInOut{Output}{Output}
\Input {data set $\mathcal{X} = {x_1, x_2, …, x_n}$,
                
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
\caption{Simple version of t-Distributed Stochastic Neighbor Embedding.}
\end{algorithm}

<!--    compute pairwise affinities $p_{j|i}$-->
<!-- set $p_{ij} = \dfrac{p_{j|i} +  p_{i|j}}{2n}$-->

 in a two or three dimensional space.

only 2D or 3D embeddings
otherwise bad performance
yielding from the Barnes-Hut tree structure
spatial 




<!--,  of t-SNE. It, that uses a Barnes-Hut [@Barnes1986] tree structure. The data is represented differently to bundle negligible calculations, which have only minimal impact on the outcome of the algorithm. This allows for a theoretical and practical speed-up of the algorithm.-->


<!-- is an dimension reduction algorithm that maps data points with high dimensional complexity to lower dimensional representations. It tries to preserve locality in between the points while doing so.-->

<!--#### t-SNE-->
<!--#### BH-SNE-->
<!--O(N log(N)), O(N) Speicher-->

<!--uses vantage-point tree-->
<!--P.N. Yianilos. Data structures and algorithms for nearest neighbor search in general metric-->
<!--spaces. In Proceedings of the ACM-SIAM Symposium on Discrete Algorithms, pages-->
<!--311–321, 1993.-->



<!--#### Other Optimized Versions of t-SNE-->


<!-- ![A figure.](figures/fslogo.pdf){width=50%} -->



<!--### t-SNE and BH-TSNE-->
<!--The fundamental algorithms to this work. t-SNE [@tsne] is an dimension reduction algorithm that maps data points with high dimensional complexity to lower dimensional representations. It tries to preserve locality in between the points while doing so.-->

<!--BH-TSNE [@Maaten2014] is an enhanced version of t-SNE, that uses a Barnes-Hut [@Barnes1986] tree structure. The data is represented differently to bundle negligible calculations, which have only minimal impact on the outcome of the algorithm. This allows for a theoretical and practical speed-up of the algorithm.-->



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
The MNIST data set [@mnist] is a commonly used example of assessing the quality of dimensionality reduction algorithms.
The figure shows that the quality of PCA is inferior to those of t-SNE and UMAP.
The points in the graphic output of PCA look merely spread out, unlike the visualizations of the other competitors, which both show clearly recognizable clusters.
The labels represented as colors show that the clusters also are correctly formed and consist of similar data.

The differences between t-SNE and UMAP are not quite as grave, but nonetheless very noticeable.
The clusters formed by t-SNE are closer together and not as dense as those created by UMAP.
Additionally UMAP has less noise in between the clusters and shows no split clusters as t-SNE does in the lower part of its visualization.

![Visualizations of data sets by PCA, t-SNE and UMAP. The figure is modified from the UMAP publication [@umap], figure 2.](figures/chapter2/modified_umap_graphic.png){#fig:viz_compare short-caption="Visualizations of data sets by PCA, t-SNE and UMAP."  width="100%"}

