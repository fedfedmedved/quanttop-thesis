from sys import path, argv
path.append('../../util')
from util import *

run(method="umap", name="google_news_500",datasets_base_path="../../../datasets", load_dataset="bin", argv=argv, callable_steps=10, plot_folder="plotted")

