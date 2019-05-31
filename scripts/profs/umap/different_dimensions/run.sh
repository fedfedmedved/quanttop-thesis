#!/bin/bash

mkdir -p cifar
mkdir -p mnist
mkdir -p plotted

for n in {1..6}; do
    for m in {1..4}; do
        python -m cProfile -o cifar/run_${n}_${m}.prof cifar.py ${n} ${m}
    done
done

for n in {1..7}; do
    for m in {1..4}; do
        python -m cProfile -o mnist/run_${n}_${m}.prof mnist.py ${n} ${m}
    done
done

