#!/bin/bash

mkdir -p profs
mkdir -p plotted

n=6
name="mnist"
python -m cProfile -o profs/$name.prof scripts/$name.py ${n}

n=5
name="cifar"
python -m cProfile -o profs/$name.prof scripts/$name.py ${n}

name="glove"
python -m cProfile -o profs/$name.prof scripts/$name.py ${n}

