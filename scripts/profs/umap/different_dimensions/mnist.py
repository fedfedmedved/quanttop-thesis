from sys import path, argv
path.append('../../util')
from util import *

run(method="umap", name="mnist",datasets_base_path="../../../datasets", load_dataset="bin", argv=argv, callable_steps=7, callable_steps_2=4, plot_folder="plotted")

