### PCA
One of the most commonly used dimensionality reduction algorithms is Principal Components Analysis (PCA).
Its origins "are often difficult to trace" according to [@Jolliffe2002], but are generally agreed upon to lay within the beginning of the 20th century.
Throughout history PCA has been discovered multiple times, which is an indicator of how fundamental the algorithm is.
PCA is very versatile and has multiple applications.
It is still frequently referenced and used in current research publications.
A common application in the field of data analysis is that of visualizing data.

<!--What PCA does-->
It is a statistical method to extract information on data's highest variance.

matrix factorization
linear
global not local
 
orthogonal vectors


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

