from sys import path, argv
path.append('../../util')
from util import *

run(method="umap", name="cifar",datasets_base_path="../../../datasets", load_dataset="bin", argv=argv, callable_steps=6, plot_folder="plotted")

