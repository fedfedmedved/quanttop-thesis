#!/bin/bash

for folder in 10_times different_dimensions google_news various; do
    echo "cd to $folder, running profiling..."
    pushd $folder
    ./run.sh
    popd
done

