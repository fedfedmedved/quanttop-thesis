from sys import path, argv
path.append('../../util')
from util import *

run(method="gpumap", name="google_news_full",datasets_base_path="../../../datasets", load_dataset="bin", argv=argv, callable_steps=30, plot_folder="plotted")

