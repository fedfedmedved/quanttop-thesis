# Methods {#methods}

## Profiling UMAP

consist of many parts

for a parallelization effort the parts that contribute most to the execution time

graphic of 


show how performance depends on the input data 
preprocess with PCA,
not lowering dimensions
just decomposing data into principal components
faster


## Parallelizing UMAP

table steps simlarity to other algorithms

|Algorithm phase| Equivalent exist in | Parallelization exists |
|-------------------|--------------|---------------|
|KNN search|t-SNE| Yes, multiple|
|Spectral layout initialization | - | No |
|SGD| - | Similar |

## Parallelization of Nearest-Neighbor Search

common problem in ML and data analysis

various implementations exist 
<!--https://github.com/erikbern/ann-benchmarks-->
reference ANN benchmark



## Parallelization of Stochastic Gradient Descent

data access reordering, only write to one y in one process to avoid write conflicts

 

negative sampling

replace check $k==j$ with $ k = k + j % max-1$


