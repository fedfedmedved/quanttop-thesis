## Background and Motivation
In the fields of neural networks, deep-learning and data science one often encounters data with very high dimensionality. To recognize patterns and clusters in this data a human perceivable representation is desired. However, due to the amount of dimensions it often is difficult to create an embedding in two or three dimensional space.

Dimension reduction algorithms try to solve this exact problem, creating a perceivable <!-- TODO --> representation of complex data. Multiple algorithms with different approaches exist, some of which are presented in [chapter two](#preliminaries). t-SNE can be seen as the state of the art algorithm. It has a variety of implementations in a multitude of languages, some of which are listed on van der Maaten's website [@VanderMaaten].

The biggest drawback for most of the implementations is their performance. They often are not parallelized and thus fail to reach
their full potential. Even the implementations that can run in parallel are limited by the capabilities of the CPU. Better performance can be achieved by computing on GPUs, for example by using the CUDA technology [@website-nvidia-cuda].

This work wants to to create a highly parallelized implementation of the t-SNE algorithm that can run 
an implemented Extraordinary performance can be accomplished when


run slower than possible perform badly on  algorithms are not Parallel ism is often not 

Most implementations have strong limitations on how processing speed and 
are very limited in the how big the data 
However, hardly 

o speed up

We

too slow
parallelization via GPU

