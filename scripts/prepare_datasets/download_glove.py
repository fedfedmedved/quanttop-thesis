import os.path
import numpy as np
import pickle
from gensim.scripts.glove2word2vec import glove2word2vec
from gensim.models.keyedvectors import KeyedVectors

name = "glove"
dataset_folder = "../datasets"
dataset_file = "{0}/{1}/{1}.bin".format(dataset_folder, name)
dataset_txt_file = "{0}/{1}/glove.840B.300d.txt".format(dataset_folder, name)

def save_data(data, filename):
    with open(filename, "wb") as f:
        pickle.dump(data, f)

if not os.path.exists(dataset_file):
    if not os.path.exists(dataset_txt_file):
        print("File", dataset_txt_file, "does not exist. This should have been")
        print("created by the glove.sh shell script.")
    else:
        tmp_file = "{0}.tmp".format(dataset_txt_file)
        glove2word2vec(glove_input_file=dataset_txt_file, word2vec_output_file=tmp_file)
        ds = KeyedVectors.load_word2vec_format(tmp_file, binary=False).vectors

        save_data(ds, dataset_file)
else:
    print("GloVe dataset already exists.")

