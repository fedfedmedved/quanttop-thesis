#!/bin/bash

for folder in 10_times 2d 3d google_news; do
    echo "cd to $folder, plotting..."
    pushd $folder
    gnuplot plot.plt
    popd
done

