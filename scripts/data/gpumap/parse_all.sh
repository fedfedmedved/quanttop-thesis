#!/bin/bash

for folder in 10_times different_dimensions google_news tsnecuda_comparison various; do
    echo "cd to $folder, parsing..."
    pushd $folder
    ./parse.sh
    popd
done

