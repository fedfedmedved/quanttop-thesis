from sklearn.datasets import load_digits

from sys import path
path.append('../../../util')
from util import *

run(method="tsnecuda", name="digits", load_dataset="sklearn", fun=load_digits, caching=False, plot_folder="../plotted")

