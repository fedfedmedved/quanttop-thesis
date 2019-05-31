from sklearn.datasets import load_iris

from sys import path
path.append('../../../util')
from util import *

run(method="gpumap", name="iris", load_dataset="sklearn", fun=load_iris, caching=False, plot_folder="../plotted")

