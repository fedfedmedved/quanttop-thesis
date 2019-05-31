from sys import path, argv
path.append('../../util')
from util import *

run(method="gpumap", name="mnist",datasets_base_path="../../../datasets", load_dataset="bin", argv=argv, callable_steps=7, plot_folder="plotted")

