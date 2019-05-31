from sys import path
path.append('../../../util')
from util import *

run(method="gpumap", name="coil_20",datasets_base_path="../../../../datasets", load_dataset="bin", plot_folder="../plotted")

