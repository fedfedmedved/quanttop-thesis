# Introduction
## Background and Motivation
In the fields of neural networks, deep-learning and data science data with very high dimensionality can often be encountered.
To recognize patterns and clusters in such data a human perceivable representation is desired.
However, due to the curse of dimensionality, visualization of complex data is difficult.
Two and three dimensional depictions are easiest for humans to perceive.
A transformation of complex data into human understandable form is desirable.

Dimensionality reduction algorithms can be used to solve this problem.
They process complex high-dimensional data into simplified versions with a lower dimensional complexity.
Clearly not all information included in the data can be preserved, some will be lost along the compression.
Thus, reduction will usually work best when the data itself is not as complex as the space it is embedded into.
For example, a circle embedded in five dimensions can not easily be visualized as is.
A good two dimensional representation of the five dimensional data would expose the circular shape.
The underlying shapes and forms that are embedded in complex spaces can be seen as manifolds on which the data points are arranged.
Under the aspect of visualization quality, representing these manifolds as accurately as possible is an important trait.

Multiple dimensionality reduction algorithms with different approaches and varying qualities exist.
t-SNE [@tsne] is the current state of the art algorithm.
This can for example be seen in the huge variety of existing implementations in a multitude of languages, some of which are listed on the creator van der Maaten's website[^website_vandermaaten].

t-SNE provides very good graphical results, which is the reason for its widespread adoption for visualizations in respective fields.
The biggest downside is that it suffers from slow performance when compared to other dimensionality reduction algorithms, like PCA.
Multiple attempts to improve this have been made.
The approaches that try to parallelize t-SNE for GPUs are described in the [next section](#relatedworks).
They were an inspiration for this thesis' aim to parallelize the UMAP algorithm.

Uniform Manifold Approximation and Projection, or UMAP for short, is a new dimensionality reduction algorithm, introduced in 2018 by McInnes et. al. [@umap].
It is building on mathematical principles of Riemannian geometry and algebraic topology.
This ground-up algorithm conception allows for multiple benefits, described in Section [2.2.3](#umap).
However, most prominently the paper shows that UMAP delivers graphical results as good or better than those of t-SNE, while performing faster.
Since no parallelized version is available as of yet, the paper only compares sequential implementations.

This thesis' purpose is to explore the possibilities of parallelizing the UMAP algorithm.
GPUs are made for massive parallel processing, allowing for a big number of calculations to be done simultaneously.
And even though GPUs have various drawbacks, they usually outperform normal CPUs due to their sheer amount of processing units.
Therefore a parallelized implementation of UMAP will bring the biggest performance gain, when done for GPUs.

Such an implementation is advantageous for various use cases.
The enhanced performance would allow for faster visualization of complex data in general.
Another motivational point is the idea of visualizing neural networks.
If the performance is good enough, the implementation could be used to provide quick regular updates on their evolutions.
After each interactive training phase the changes of the network's layers could be analyzed, without prolonged periods of waiting.
A parallel implementation of UMAP for GPUs could make this possible.

[^website_vandermaaten]: `https://lvdmaaten.github.io/tsne`, accessed 20.04.2019.
