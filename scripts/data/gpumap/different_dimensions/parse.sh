#!/bin/bash
base_folder="../../../profs/gpumap/different_dimensions"
python_script="../../util/print_stats.py"
header_string="#N    M    JIT  Total  Fuzzy KNN Optimize Embed"
method_filter="fit|fuzzy_simplicial|nearest_neighbors|optimize|__call__|spectral_layout|simplicial_set|_compile_for_args"

parse_different_dimensions() {
    name=$1
    folder="$base_folder/$name"
    output=$name.dat
    tmp_output=$output.tmp

    rm -f $output

    echo "#from $folder" >> $output
    echo $header_string >> $output

    for n in $(seq 1 $2); do
        for m in $(seq 1 $3); do
            dims=$(($m*$4))
            size=$(($n*$5))
            echo -n "$size $dims " >> $output
            python $python_script "$folder/run_${n}_$m.prof" | grep -E $method_filter | awk '{print $4}' | tr '\n' ' ' >> $output
            echo >> $output
        done
    done
    awk '{print $1 " " $2 " " $4 " " $6 " " $5 " " $8 " " $3 " " $7}' $output > $tmp_output
    ./../../util/align.sh $tmp_output > $output
    rm $tmp_output
}

parse_different_dimensions "mnist" 7 4 196 10000
parse_different_dimensions "cifar" 6 4 768 10000


