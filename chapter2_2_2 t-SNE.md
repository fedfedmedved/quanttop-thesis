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

<!--\SetAlgoLined-->
<!--\KwResult{Write here the result}-->
<!--TODO remove line numbering-->
\begin{algorithm}[H]
\SetKwInOut{Input}{Input}\SetKwInOut{Output}{Output}
\Input {data set $\mathcal{X} = {x_1, x_2, …, x_n}$,
                
    \ \ \ \ \ \ \ \ \ \ \ \ \ \ cost function parameters: perplexity $\mathcal{u}$,
    
    \ \ \ \ \ \ \ \ \ \ \ \ \ \ optimization parameters: number of iterations $T$ , learning rate $\eta$, momentum $\alpha (t)$.
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


