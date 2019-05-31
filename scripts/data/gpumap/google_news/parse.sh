#!/bin/bash
folder="../../../profs/gpumap/google_news/profs"
python_script="../../util/print_stats.py"
header_string="#N M JIT Total hmm Fuzzy KNN Optimize Embed Spectral"
method_filter="_compile_bytecode|fit|fuzzy_simplicial_set|nearest_neighbors|optimize_layout|simplicial_set_embedding|spectral_layout"

parse_different_sizes() {
    name=$1
    output=$name.dat
    tmp_output=$output.tmp

    rm -f $output

    echo "#from $folder" >> $output
    echo $header_string >> $output

    for n in $(seq 1 $2); do
        dims=$(($3))
        size=$(($n*$4))
        echo -n "$size $dims " >> $output
        python $python_script "$folder/run_size_$n.prof" | grep -E $method_filter | awk '{print $4}' | tr '\n' ' ' >> $output
        echo >> $output
    done
    awk '{print $1 " " $2 " " $4 " " $7 " " $6 " " $9 " " $3 " " $10}' $output > $tmp_output
    ./../../util/align.sh $tmp_output > $output
    rm $tmp_output
}

parse_different_sizes "google_news" 30 300 100000

