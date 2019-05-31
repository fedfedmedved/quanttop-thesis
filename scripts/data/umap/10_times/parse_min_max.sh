#!/bin/bash
base_folder="../../../profs/umap/10_times"
header_string="#N M JIT Total Fuzzy KNN Optimize Embed"
header_string_err="#N Min Max M Min Max Total Min Max KNN Min Max Fuzzy Min Max Embed Min Max JIT Min Max"
method_filter="_compile_bytecode|fit|fuzzy_simplicial_set|nearest_neighbors|optimize_layout|simplicial_set_embedding|spectral_layout"
python_script="../../util/print_stats.py"

parse_min_max() {
    name=$1
    folder="$base_folder/$name"
    out_file="${name}_min_max.dat"
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
        cat $out_file | grep "$size" | awk 'NR==1 { for (i=1; i<=NF; i++) {max[i]=0 ; min[i]=10000000 }} {for (i=1; i<=NF; i++) {sum[i]+= $i; max[i] = (max[i] < $i ? $i : max[i]); min[i] = (min[i] < $i ? min[i] : $i)}} END { for (i=1; i<=NF; i++ ) { printf "%f %f %f ", sum[i]/NR, min[i], max[i]}}' >> $tmp_file
        echo >> $tmp_file
    done

    ./../../util/align.sh $tmp_file > $out_file
    echo "#from $folder" >> $out_file

    rm -f $tmp_file
}

parse_min_max "mnist" 784 7 10000
parse_min_max "cifar" 3072 6 10000
parse_min_max "google_news" 300 10 50000

