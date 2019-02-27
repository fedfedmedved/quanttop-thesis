### UMAP {#umap}
Uniform Manifold Approximation and Projection, or UMAP for short, was introduced in 2018 by McInnes et al. [@umap].
The algorithm was inspired by [t-SNE](#tsne), as stated in [@umap-talk-pydata].
The intention was to create a similar dimensionality reduction algorithm that is based on a mathematical foundation.
As UMAP was introduced as late as 2018, no literature is available at the time of writing.
The primary resources on UMAP, besides the publication itself, are the source code [repository](https://github.com/lmcinnes/umap/) and several talks of McInnes on the matter.

The math behind the algorithm will be not be discussed in detail here, since it is of no interest to this thesis' goals.
Instead a broad outline will suffice.
The primary focus is on explaining how the mathematical concepts are used, so that the analysis of their parallelization in the [following chapter](#methods-umap) is comprehensible.


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




<!-- TODO mention partial update -->

