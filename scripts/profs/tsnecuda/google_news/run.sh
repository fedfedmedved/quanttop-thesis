#!/bin/bash

mkdir -p google_news
mkdir -p plotted

for n in {1..10}; do
    python -m cProfile -o google_news/run_size_${n}.prof google_news.py ${n}
done

