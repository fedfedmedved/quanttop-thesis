#!/bin/bash

mkdir -p profs
mkdir -p plotted

for n in {1..30}; do
    python -m cProfile -o profs/run_size_${n}.prof google_news.py ${n}
done

