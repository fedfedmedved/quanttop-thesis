#!/bin/bash

folder="../../../profs/gpumap/tsnecuda_comparison/profs"
store_folder="."
python_script="../../util/print_stats.py"
output="tsnecuda_comparison.dat"
tmp_output=$output.tmp
header_string="#DS N M JIT Total hmm Fuzzy KNN Optimize Embed"
method_filter="_compile_bytecode|fit|fuzzy_simplicial_set|nearest_neighbors|optimize_layout|simplicial_set_embedding|spectral_layout"

echo $header_string > $store_folder/$output

parse_dataset() {
    name=$1
    beautiful_name=$2
    echo -n "$beautiful_name $3 $4 " >> $store_folder/$output
    python $python_script "$folder/${name}.prof" | grep -E $method_filter | awk '{print $4}' | tr '\n' ' ' >> $store_folder/$output
    echo  >> $store_folder/$output
}

parse_dataset "mnist" "MNIST" 60000 784
parse_dataset "cifar" "CIFAR" 50000 3072
parse_dataset "glove" "GloVe" 2196017 300

awk '{print $1 " " $2 " " $3 " " $5 " " $8 " " $7 " " $10 " " $4}' $output > $tmp_output

./../../util/align.sh $tmp_output > $output
rm $tmp_output

