unset key
unset colorbox

set view 65,20,1,1
set lmargin at screen 0.16
set rmargin at screen 0.845
set bmargin at screen 0.205
set tmargin at screen 0.87
set xlabel "N data points" offset -1,-1.5
set ylabel "M dimensions" offset 3.8,-1
set zlabel "time in s" offset 3,0 rotate by 90

set zrange [4:256]

set ticslevel 0
set xtics offset -3,-.5
set ytics offset -0.8,-0.4
#set logscale z 2
set ztics mirror
set ztics 32
set ztics offset 0.7,0.5
set mztics 5
set grid x y z vertical

set dgrid3d 4,6
set hidden3d
set pm3d at s interpolate 10,10; set palette rgbformulae 3,5

set terminal png size 1400,800 enhanced font "Arial,20"

#mnist
set xrange [10000:70000]
set yrange [196:784]
set ytics 196

dataset_mnist = "../../../data/umap/different_dimensions/mnist.dat"

set output 'mnist/plot_umap_mnist_total.png'
splot dataset_mnist u 1:2:3 with lines
set output 'mnist/plot_umap_mnist_NN.png'
splot dataset_mnist u 1:2:4 with lines
set output 'mnist/plot_umap_mnist_fuzzy_set.png'
splot dataset_mnist u 1:2:5 with lines
set output 'mnist/plot_umap_mnist_embed.png'
splot dataset_mnist u 1:2:6 with lines
set output 'mnist/plot_umap_mnist_compile.png'
splot dataset_mnist u 1:2:7 with lines

#cifar
set xrange [10000:60000]
set yrange [768:3072]
set ytics 768

dataset_cifar = "../../../data/umap/different_dimensions/cifar.dat"

set output 'cifar/plot_umap_cifar_total.png'
splot dataset_cifar u 1:2:3 with lines
set output 'cifar/plot_umap_cifar_NN.png'
splot dataset_cifar u 1:2:4 with lines
set output 'cifar/plot_umap_cifar_fuzzy_set.png'
splot dataset_cifar u 1:2:5 with lines
set output 'cifar/plot_umap_cifar_embed.png'
splot dataset_cifar u 1:2:6 with lines
set output 'cifar/plot_umap_cifar_compile.png'
splot dataset_cifar u 1:2:7 with lines

#merged
set xrange [10000:60000]
set yrange [196:3072]
set ytics (768,1536,2304,3072)

set output 'merged/merged_total.png'
splot dataset_mnist u 1:2:3 with lines,\
      dataset_cifar u 1:2:3 with lines
set output 'merged/merged_NN.png'
splot dataset_mnist u 1:2:4 with lines,\
      dataset_cifar u 1:2:4 with lines
set output 'merged/merged_fuzzy_set.png'
splot dataset_mnist u 1:2:5 with lines,\
      dataset_cifar u 1:2:5 with lines
set output 'merged/merged_embed.png'
splot dataset_mnist u 1:2:6 with lines,\
      dataset_cifar u 1:2:6 with lines
set output 'merged/merged_comile.png'
splot dataset_mnist u 1:2:7 with lines,\
      dataset_cifar u 1:2:7 with lines
