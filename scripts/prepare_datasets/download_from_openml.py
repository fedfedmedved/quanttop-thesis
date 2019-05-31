import pickle
import numpy as np
import os.path
from sklearn.datasets import fetch_openml

def save_data(data, filename):
    with open(filename, "wb") as f:
        pickle.dump(data, f)

def load_from_openml(openml_name, name, base_path):
    print("Fetching {0}".format(name))
    dataset_file="{0}/{1}/{1}.bin".format(base_path, name)

    if not os.path.exists(dataset_file):
        dataset = fetch_openml(
            openml_name, version=1, data_home="{0}/{1}".format(base_path, name)
        )
        dataset.data = np.ascontiguousarray(dataset.data)
        save_data(dataset, dataset_file)
    else:
        print("{0} already exists.".format(name))

base_path = "../datasets"

load_from_openml("Fashion-MNIST", "fashion_mnist", base_path)
load_from_openml("mnist_784", "mnist", base_path)
load_from_openml("CIFAR_10", "cifar", base_path)

