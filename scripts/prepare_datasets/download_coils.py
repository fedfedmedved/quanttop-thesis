# with code from:
# https://github.com/overshiki/datasets/blob/master/general/utils.py
# https://github.com/overshiki/datasets/blob/master/coil20/download.py

import pickle
import numpy as np
import os.path
from sklearn.datasets import fetch_openml
from chainer.dataset import download as dl, set_dataset_root as set_cache
import zipfile
import tempfile, os, shutil, cv2, re
from sklearn.datasets import load_iris

def save_data(data, filename):
    with open(filename, "wb") as f:
        pickle.dump(data, f)

def imreadBGR(path, img_type):
    '''use opencv to load jpeg, png image as numpy arrays, the speed is triple compared with skimage
    '''
    return cv2.imread(path,img_type)

def download(base_path, name, url, img_type):
    cache_root = "{0}/{1}/cache".format(base_path, name)
    print ("Caching to {0}".format(cache_root))
    set_cache(cache_root)

    archive_path = dl.cached_download(url)
    fileOb = zipfile.ZipFile(archive_path, mode='r')
    names = fileOb.namelist()

    try:
        os.makedirs(cache_root)
    except OSError:
        if not os.path.isdir(cache_root):
            raise

    data, label = [], []
    try:
        for name in names:
                path = cache_root+name
                if bool(re.search('obj', name)):
                    obj=fileOb.extract(name, path=path)
                    img = imreadBGR(obj, img_type)
                    data.append(img)
                    label.append(int(name.split("__")[0].split("/obj")[1]))
    finally:
        print("processed {0} images".format(len(names)))
        #shutil.rmtree(cache_root)
    #data = np.stack(data, axis=0).transpose([0, 3, 1, 2])
    label = np.array(label).astype(np.uint8)
    return data, label

def download_coil(base_path, name, url, img_type):
    dataset_file="{0}/{1}/{1}.bin".format(base_path, name)
    if not os.path.exists(dataset_file):
        print("Downloading {0}".format(name))

        # only used to create a basic dataset layout
        dataset = load_iris()
        dataset.data, dataset.target = download(base_path, name, url, img_type)
        ds = np.array(dataset.data)
        second_shape = 1
        for i in range(1, len(ds.shape)):
            second_shape *= ds.shape[i]
        ds = ds.reshape(ds.shape[0],second_shape)
        dataset.data = ds

        print("Saving to {0}".format(dataset_file))
        save_data(dataset, dataset_file)
        return True
    else:
        return False

base_path = "../datasets"

# coil 20
coil20_url_unprocessed = "http://www.cs.columbia.edu/CAVE/databases/SLAM_coil-20_coil-100/coil-20/coil-20-unproc.zip"
coil20_url_processed = 'http://www.cs.columbia.edu/CAVE/databases/SLAM_coil-20_coil-100/coil-20/coil-20-proc.zip'

if not download_coil(base_path, "coil_20", coil20_url_processed, cv2.IMREAD_GRAYSCALE):
    print("COIL-20 already exists")

# coil 100
coil100_url = "http://www.cs.columbia.edu/CAVE/databases/SLAM_coil-20_coil-100/coil-100/coil-100.zip"

if not download_coil(base_path, "coil_100", coil100_url, cv2.IMREAD_COLOR):
    print("COIL-100 already exists")
