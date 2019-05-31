#!/bin/bash
base_folder="../../../profs/umap/10_times"
header_string="#N M JIT Total Fuzzy KNN Optimize Embed"
header_string_err="#N Error M Error Total Error KNN Error Fuzzy Error Embed Error JIT Error"
method_filter="_compile_bytecode|fit|fuzzy_simplicial_set|nearest_neighbors|optimize_layout|simplicial_set_embedding|spectral_layout"
python_script="../../util/print_stats.py"

parse_standard_error() {
    name=$1
    folder="$base_folder/$name"
    out_file="${name}_standard_error.dat"
    tmp_file="$out_file.tmp"

    rm -f $out_file
    rm -f $tmp_file

    dims=$2

    echo $header_string >> $tmp_file

    for n in $(seq 1 $3); do
        for m in {1..10}; do
            size=$(($n*$4))
            echo -n "$size $dims " >> $tmp_file
            python $python_script "$folder/run_size_${n}_number_$m.prof" | grep -E $method_filter | awk '{print $4}' | tr '\n' ' ' >> $tmp_file
            echo >> $tmp_file
        done
    done

    awk '{print $1 " " $2 " " $4 " " $6 " " $5 " " $8 " " $3}' $tmp_file > $out_file

    rm -f $tmp_file

    echo $header_string_err >> $tmp_file
    for n in $(seq 1 $3); do
        size=$(($n*$4))
        cat $out_file | grep "$size" | awk '{for (i=1; i<=NF; i++) { sum[i]+= $i; sumsq[i] += ($i)^2 } } END { for (i=1; i<=NF; i++ ) { printf "%f %f ", sum[i]/NR, sqrt((sumsq[i]-sum[i]^2/NR)/(NR-1))}}' >> $tmp_file
        echo >> $tmp_file
    done

    ./../../util/align.sh $tmp_file > $out_file
    echo "#from $folder" >> $out_file

    rm -f $tmp_file
}

parse_standard_error "mnist" 784 7 10000
parse_standard_error "cifar" 3072 6 10000
parse_standard_error "google_news" 300 10 50000

