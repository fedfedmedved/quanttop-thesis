from sklearn.datasets import fetch_lfw_people

from sys import path
path.append('../../../util')
from util import *

run(method="umap", name="lfw",datasets_base_path="../../../../datasets", load_dataset="sklearn", fun=fetch_lfw_people, plot_folder="../plotted")

