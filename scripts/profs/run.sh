#!/bin/bash

mkdir -p profs
mkdir -p plotted

pushd "scripts"

for d in iris; do # digits lfw mnist fashion_mnist cifar coil_20 coil_100 google_news_200 google_news_500 google_news_full; do
    python -m cProfile -o ../profs/$d.prof $d.py
done

popd

