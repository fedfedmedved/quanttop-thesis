#!/bin/bash

dataset_folder="../datasets/glove"

mkdir -p $dataset_folder

#if not exists 
if [ ! -f $dataset_folder/glove.bin ]; then
    echo "Downloading GloVe dataset"

    pushd $dataset_folder
    txtfile="glove.840B.300d.txt"

    if [ ! -f $txtfile ]; then
        zipfile="glove.840B.300d.zip"

        if [ ! -f $zipfile ]; then
            wget --show-progress http://nlp.stanford.edu/data/wordvecs/$zipfile
        fi
        unzip $zipfile
        rm $zipfile
    fi
    popd

    python download_glove.py
fi

