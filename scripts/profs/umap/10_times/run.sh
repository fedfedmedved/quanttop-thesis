#!/bin/bash

mkdir -p cifar
mkdir -p mnist
mkdir -p google_news
mkdir -p plotted

for n in {1..6}; do
    for m in {1..10}; do
        python -m cProfile -o cifar/run_size_${n}_number_${m}.prof cifar.py ${n}
    done
done

for n in {1..7}; do
    for m in {1..10}; do
        python -m cProfile -o mnist/run_size_${n}_number_${m}.prof mnist.py ${n}
    done
done

for n in {1..10}; do
    for m in {1..10}; do
        python -m cProfile -o google_news/run_size_${n}_number_${m}.prof google_news.py ${n}
    done
done

