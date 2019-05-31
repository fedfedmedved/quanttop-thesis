import os.path
import gzip
import shutil
import gensim
import numpy as np
import pickle

name = "google_news"
dataset_folder = "../datasets"
dataset_file = "{0}/{1}/GoogleNews-vectors-negative300.bin".format(dataset_folder, name)
dataset_file_200 = "{0}/{1}_200/{1}_200.bin".format(dataset_folder, name)
dataset_file_500 = "{0}/{1}_500/{1}_500.bin".format(dataset_folder, name)
dataset_file_full = "{0}/{1}_full/{1}_full.bin".format(dataset_folder, name)

def download_gnews(dataset_file):
    compressed_file='{0}.gz'.format(dataset_file)

    if not os.path.exists(compressed_file):
        print("GoogleNews data set does not exist yet, downloading...")
        from google_drive_downloader import GoogleDriveDownloader as gdd

        #download
        gdd.download_file_from_google_drive(file_id='0B7XkCwpI5KDYNlNUTTlSS21pQmM',
                                            dest_path='{0}.gz'.format(dataset_file),
                                            unzip=False)
    #extract
    with gzip.open(compressed_file, 'rb') as f_in:
        with open(dataset_file, 'wb') as f_out:
            shutil.copyfileobj(f_in, f_out)

if not os.path.exists(dataset_file):
    download_gnews(dataset_file)

if not os.path.exists(dataset_file):
    print("Downloading failed, please manually download GoogleNews data set and")
    print("place it under {0}. Then call this script again.".format(dataset_folder))
    print("Download URL: https://drive.google.com/file/d/0B7XkCwpI5KDYNlNUTTlSS21pQmM")
else:
    if os.path.exists(dataset_file_full) and os.path.exists(dataset_file_200) and os.path.exists(dataset_file_500):
        print("GoogleNews dataset already exists.")
    else:
        def save_data(data, filename):
            with open(filename, "wb") as f:
                pickle.dump(data, f)

        # Load Google's pre-trained Word2Vec model.
        model = gensim.models.KeyedVectors.load_word2vec_format(dataset_file, binary=True)
        print("GoogleNews Data set found")
        ds = model.vectors

        if not os.path.exists(dataset_file_full):
            ds = np.ascontiguousarray(ds)

            folder="{0}/{1}_full/".format(dataset_folder, name)
            if not os.path.exists(folder):
                os.makedirs(folder)

            print("Saving full dataset")
            save_data(ds, dataset_file_full)

        if not os.path.exists(dataset_file_500):
            ds_size=ds.shape[0]
            ds_desired_size=500000

            print("Reducing size to {0}".format(ds_desired_size))

            a = range(ds_size - ds_desired_size)
            ds = np.delete(ds, a, axis=0)
            ds = np.ascontiguousarray(ds)

            folder="{0}/{1}_500/".format(dataset_folder, name)
            if not os.path.exists(folder):
                os.makedirs(folder)

            print("Saving")
            save_data(ds, dataset_file_500)

        if not os.path.exists(dataset_file_200):
            ds_size=ds.shape[0]
            ds_desired_size=200000

            print("Reducing size to {0}".format(ds_desired_size))

            a = range(ds_size - ds_desired_size)
            ds = np.delete(ds, a, axis=0)

            folder="{0}/{1}_200/".format(dataset_folder, name)
            if not os.path.exists(folder):
                os.makedirs(folder)

            print("Saving")
            save_data(ds, dataset_file_200)

