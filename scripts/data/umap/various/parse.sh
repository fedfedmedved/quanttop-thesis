#!/bin/bash

folder="../../../profs/umap/various/profs"
store_folder="."
python_script="../../util/print_stats.py"
output="various.dat"
tmp_output=$output.tmp
header_string="#Dataset N M JIT Total Fuzzy KNN Optimize Embed"
method_filter="_compile_bytecode|fit|fuzzy_simplicial_set|optimize_layout|nearest_neighbors|simplicial_set_embedding|spectral_layout"

echo $header_string > $store_folder/$output

parse_dataset() {
    name=$1
    beautiful_name=$2
    echo -n "$beautiful_name $3 $4 " >> $store_folder/$output
    python $python_script "$folder/$name.prof" | grep -E $method_filter | awk '{print $4}' | tr '\n' ' ' >> $store_folder/$output
    echo  >> $store_folder/$output
}

parse_dataset "iris" "Iris" 150 4
parse_dataset "coil_20" "COIL-20" 1440 16384
parse_dataset "digits" "Digits" 1797 64
parse_dataset "lfw" "LFW" 13233 2914
parse_dataset "coil_100" "COIL-100" 7200 49152
parse_dataset "mnist" "MNIST" 70000 784
parse_dataset "fashion_mnist" "F-MNIST" 70000 784
parse_dataset "cifar" "CIFAR" 60000 3072
parse_dataset "google_news_200" "GoogleNews" 200000 300
parse_dataset "google_news_500" "GoogleNews" 500000 300
parse_dataset "google_news_full" "GoogleNews" 3000000 300

awk '{print $1 " " $2 " " $3 " " $5 " " $7 " " $6 " " $9 " " $4}' $output > $tmp_output

./../../util/align.sh $tmp_output > $output
rm $tmp_output

