from sys import path, argv
path.append('../../util')
from util import *

run(method="gpumap", name="glove",datasets_base_path="../../../datasets", load_dataset="bin", plot_folder="plotted")

