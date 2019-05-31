import pickle
import time
import numpy as np
import umap
import gpumap
#import tsnecuda
import matplotlib
import matplotlib.pyplot as plt

base_bath = "../../datasets"


def load_data(filename):
    try:
        with open(filename, "rb") as f:
            data = pickle.load(f)
    except:
        print("Faulty path at {0}".format(filename))
        data = []
    return data


def scale_down(data, desired_size=None, desired_dims=None):
    if desired_size != None:
        current_size = data.shape[0]
        if current_size > desired_size:
            print("Reducing dataset size from {0} to {1}".format(current_size, desired_size))
            tmp_range = range(current_size - desired_size)
            data = np.delete(data,tmp_range, axis=0)
        elif current_size < desired_size:
            print("Given size is too big.")
        else:
            print("No size reduction needed.")

    if desired_dims != None:
        current_dims = data.shape[1]
        if current_dims > desired_dims:
            print("Reducing dataset dimensions from {0} to {1}".format(current_dims, desired_dims))
            tmp_range = range(current_dims - desired_dims)
            data = np.delete(data, tmp_range, axis=1)
        elif current_dims < desired_dims:
            print("Given percentage is too high.")
        else:
            print("No dimension reduction needed.")
    data = np.ascontiguousarray(data)
    return data


def dimensionality_reduction(method, name, data):
    if method == "tsnecuda":
        reducer = tsnecuda.TSNE(n_components=2, perplexity=15, learning_rate=10)
        print("Running {0}, dataset shape is {1}".format(method, data.shape))
        start = time.time()
        emb = reducer.fit_transform(data)
        end = time.time()
        print("Processing took {0} seconds".format(end-start))
        return emb

    if method == "umap":
        reducer = umap.UMAP()
    elif method == "gpumap":
        reducer = gpumap.GPUMAP(verbose=True)
    else:
        print("No valid reduction method given.")
        return None

    print("Running {0}, dataset shape is {1}".format(method, data.shape))
    start = time.time()
    emb = reducer.fit(data).embedding_
    end = time.time()
    print("Processing took {0} seconds".format(end-start))

    return emb


def plot_data(plot_name, emb, label=None, size_plot_points=0.5 ,plot_folder=".", colorbar=False):
    matplotlib.use('pdf')

    plt.scatter(emb[:, 0], emb[:, 1], c=label, cmap='Spectral', s=size_plot_points)
    plt.gca().set_aspect('equal', 'datalim')
    if colorbar:
        if not label.__str__() == 'None':
            plt.colorbar(boundaries=np.arange(11)-0.5)
        else:
            print("No labels given, can not plot with labels.")

    plt.savefig('{0}/{1}'.format(plot_folder, plot_name), dpi=600, bbox_inches='tight', pad_inches=0.0)


def get_label(dataset):
    if hasattr(dataset, 'target'):
        label = dataset.target.astype(int)
    elif hasattr(dataset, 'label'):
        label = dataset.label.astype(int)
    else:
        label = None
    return label


def run_from_sklearn(fun, name, caching=False):
    run_gpumap(name=name,load_dataset="sklearn", fun=fun, caching=caching)


def run_from_bin(name, desired_size=None):
    run_gpumap(name=name, load_dataset="bin")


def load_dataset_from_sklearn(fun, name, caching=False, datasets_base_path=None):
    if caching and datasets_base_path == None:
        print("caching enabled, but no datasets path given, disabling")
        caching = False
    if caching:
        print("caching")
        dataset = fun(data_home="{0}/{1}".format(datasets_base_path,name))
    else:
        dataset = fun()
    return dataset


def load_dataset_from_bin(name, datasets_base_path):
    dataset_path = "{0}/{1}/{1}.bin".format(datasets_base_path, name)
    return load_data(dataset_path)


def steps(step, step_size, max_steps):
    if step > max_steps:
        print("Too high of a step given, using max size ({0})".format(max_steps*step_size))
        step = max_steps
    return step * step_size

    
def percent(step, n_percent_steps):
    if step > n_percent_steps:
        print("Too high of a percentage given, using 100%")
        step = n_percent_steps
    return float(step) / float(n_percent_steps)


def parse_args(argv, step_size, max_steps, n_percent_steps=None):
    if not argv:
        print("called parsing without data to parse")
        return
    if len(argv) == 1:
        print("No args given, might be a problem, but ignoring")
    elif len(argv) > 3:
        print("Too many args given, might be a problem, but ignoring")

    if len(argv) > 1:
        size = steps(int(argv[1]), step_size, max_steps)
    else:
        size = max_steps * step_size
    if len(argv) > 2:
        if not n_percent_steps:
            print("Two parameters supplied but no percent steps defined.")
        else:
            percent_dims = percent(int(argv[2]), n_percent_steps)
    else:
        percent_dims = None
        
    return (size, percent_dims)


def run(method=None, name="", datasets_base_path=None, fun=None, load_dataset="bin", callable_steps=None, callable_steps_2=None, caching=False, size_plot_points=0.5, plot_folder=".", argv=None, plot=True, colorbar=False):
    desired_size = None
    desired_dims = None

    if not method:
        print("No method specified! Use either \"umap\", \" gpumap\" or \"tsnecuda\"")
        return

    if load_dataset=="bin":
        dataset = load_dataset_from_bin(name=name, datasets_base_path=datasets_base_path)
    elif load_dataset=="sklearn":
        if not fun:
            print("Using sklearn, but no fun :(")
            return
        dataset = load_dataset_from_sklearn(name=name, fun=fun, caching=caching, datasets_base_path=datasets_base_path)
    else:
        print("invalid load value")
        return

    if hasattr(dataset,'data'):
        data = dataset.data
    else:
        data = dataset
    data = np.ascontiguousarray(data)

    if argv:
        if not callable_steps:
            print("argv was given without callable steps!")
            return
        else:
            data_size = data.shape[0]
            step_size = data_size // callable_steps
            
            if data_size % callable_steps:
                print("Data size ({0}) is not dividable by step size ({1})!".format(data_size, step_size))
                return
            else:
                desired_size, percent_dims = parse_args(argv, step_size, callable_steps, callable_steps_2)
                if percent_dims:
                    current_dims = data.shape[1]
                    desired_dims = int(current_dims * percent_dims)
                else:
                    desired_dims = None

                if desired_size or desired_dims:
                    data = scale_down(data=data, desired_size=desired_size, desired_dims=desired_dims)
    else:
        print("no argv passed, using data set as is")

    emb = dimensionality_reduction(method=method, name=name, data=data)
    
    if plot:
        label=get_label(dataset=dataset)

        if desired_size and desired_dims:
            plot_name = "{0}_N_{1}_M_{2}.png".format(name, desired_size, desired_dims)
        elif desired_size:
            plot_name = "{0}_N_{1}.png".format(name, desired_size)
        else:
            plot_name = "{0}.png".format(name)

        if desired_size and not label.__str__() == 'None':
            label = label[:desired_size]

        plot_data(plot_name=plot_name, emb=emb, label=label, size_plot_points=size_plot_points, plot_folder=plot_folder, colorbar=colorbar)

    print("")
    
    return emb

