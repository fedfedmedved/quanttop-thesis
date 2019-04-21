# Implementation

## Used Technologies
To implement UMAP on GPUs, a library to communicate with the GPU needs to be chosen.
The choice for this thesis was to use the CUDA library.
As already argued in [section 1.3](#aim), it provides good performance and is widespread.
Furthermore its API is mature and stable.

In order not to need to start from scratch, the UMAP publication's Python implementation is used as groundwork.
Building upon it, all parts that in [chapter 3](#methods) were found to benefit from parallelization, will be extended to support execution on GPUs.
Thanks to the adaptability of the Python language, the CPU parts can still remain intact.
This way they can be used as a fallback, for example when no GPU should be available, even if just temporarily.

As mentioned in the previous chapter, UMAP uses Numba to create compiled code during execution.
This often allows for faster execution, then
CUDA

## Implementation Details

### `nearest_neighbors`
FAISS Python interface

Index
add
train
search

brute-force

### `fuzzy_simplicial_set`
existing code contained comment about it not being optimized

redundant caculations

binary search for value

calculate max, mean, value at position and position in one iteration

### `optimize_layout`

move other needed
image if not

therefore atomics

not possible to 


random generation with modulo

hole with if x: break


