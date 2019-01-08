## Background and Motivation
In the fields of neural networks, deep-learning and data science one often encounters data with very high dimensionality.
To recognize patterns and clusters in this data a human perceivable representation is desired.
However, due to the amount of dimensions it is often difficult to create a depiction in two or three dimensional space.

Dimensionality reduction algorithms can be used to solve this problem.
They process complex high-dimensional data into simplified versions with a lower dimensional complexity.
Clearly not all information include in the data can be preserved, some will get lost along the compression.
Thus reduction will usually work best if the data itself is not as complex as the space it is embedded into.
For example consider a circular shape placed in a five dimensional space.
It could not easily be visualized as is, but a good two dimensional representation would expose the same circular shape.
The underlying shapes and forms that are embedded in complex spaces can be seen as manifolds on which the data points are arranged.
Under the aspect of visualization representing these manifolds as correct as possible is an important trait.

Multiple dimensionality reduction algorithms with different approaches and varying qualities exist.
(A selection is presented in [chapter two](#preliminaries).)
Overall t-SNE [@VanDerMaaten2008] can be seen as the current state of the art algorithm.
This can for example be seen in the big variety of existing implementations in a multitude of languages, some of which are listed on the creator [van der Maaten's website](https://lvdmaaten.github.io/tsne/).

t-SNE provides very good graphical results, which is the reason for its widespread adoption for visualizations in respective fields.
<!-- TODO maybe find some paper for this? -->
The biggest downside is that it suffers from slow performance when compared to other dimensionality reduction algorithms, like PCA.
Multiple attempts to improve this have been made.
The approaches that try to parallelize t-SNE for GPUs are described in the [next section](#relatedworks).
They were an inspiration for this thesis' aim to parallelize the UMAP algorithm.

Uniform Manifold Approximation and Projection, or UMAP for short, is a new dimensionality reduction algorithm, introduced in 2018 by McInnes et. al. [@McInnes2018].
It is building on mathematical principles of Riemannian geometry and algebraic topology.
This ground-up algorithm conception allows for multiple benefits, described in chapter [2.2.3](#umap).
However most prominently the paper shows that UMAP delivers graphical results as good or better than those of t-SNE, while performing faster.
Since no parallelized version is available as of yet, the paper only compares sequential implementations.

With this thesis we want to explore the possibilities of parallelizing the UMAP algorithm and provide an initial implementation for GPUs.
Such an implementation would be advantageous for various use cases.
Faster visualization of complex data could be used to give regular updates on series of high dimensional data that is still changing.
For example a neural network's evolution could be visualized, in order to see the changes of each layer during training phases.
