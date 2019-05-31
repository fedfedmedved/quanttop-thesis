set key left top
unset colorbox

set view 70,20,1,1
set lmargin at screen 0.07
set rmargin at screen 0.94
set bmargin at screen 0.1
set tmargin at screen 0.97

set xlabel "N data points" offset 0,0.5
set ylabel "time in s" offset 3,0 rotate by 90

set yrange [8:256]
set y2range [8:256]

set ticslevel 0
#set xtics offset -3,-.5
#set ytics offset -0.8,-0.4
set y2tics
#set mytics 8
#set my2tics 8
#set logscale y 2
#set logscale y2 2
set grid x y vertical

# color definitions
set style line 1 lc rgb '#8b1a0e' pt 1 ps 1.5 lt 1 lw 5 # --- red
set style line 2 lc rgb '#5e9c36' pt 6 ps 1.5 lt 1 lw 5 # --- green
set style line 3 lc rgb '#0060ad' pt 2 ps 1.5 lt 1 lw 5 # --- blue
set style line 4 lc rgb '#34006d' pt 4 ps 1.5 lt 1 lw 5 # --- purple
set style line 5 lc rgb '#8e551b' pt 8 ps 1.5 lt 1 lw 5 # --- 

set terminal png size 1400,800 enhanced font "Arial,20"

#cifar
set xrange [10000:60000]

dataset_cifar = '../../../data/umap/different_dimensions/cifar.dat'

set output 'plot_2d_cifar.png'
plot  every 4:1:3 u 1:3 notitle smooth csplines ls 1,\
     dataset_cifar every 4:1:3 u 1:4 notitle smooth csplines ls 2,\
     dataset_cifar every 4:1:3 u 1:5 notitle smooth csplines ls 3,\
     dataset_cifar every 4:1:3 u 1:6 notitle smooth csplines ls 4,\
     dataset_cifar every 4:1:3 u 1:7 notitle smooth csplines ls 5,\
     dataset_cifar every 4:1:3 u 1:3 notitle with points ls 1,\
     dataset_cifar every 4:1:3 u 1:4 notitle with points ls 2,\
     dataset_cifar every 4:1:3 u 1:5 notitle with points ls 3,\
     dataset_cifar every 4:1:3 u 1:6 notitle with points ls 4,\
     dataset_cifar every 4:1:3 u 1:7 notitle with points ls 5,\
     1 / 0 title "Total Time" with linespoints ls 1,\
     2 / 0 title "Nearest Neighbors" with linespoints ls 2,\
     3 / 0 title "Distance Normalization" with linespoints ls 3,\
     4 / 0 title "Layout Optimization" with linespoints ls 4,\
     5 / 0 title "JIT Compiling" with linespoints ls 5

#mnist
set xrange [10000:60000]

dataset_mnist = '../../../data/umap/different_dimensions/mnist.dat'

set output 'plot_2d_mnist.png'
plot  every 4:1:3 u 1:3 notitle smooth csplines ls 1,\
     dataset_mnist every 4:1:3 u 1:4 notitle smooth csplines ls 2,\
     dataset_mnist every 4:1:3 u 1:5 notitle smooth csplines ls 3,\
     dataset_mnist every 4:1:3 u 1:6 notitle smooth csplines ls 4,\
     dataset_mnist every 4:1:3 u 1:7 notitle smooth csplines ls 5,\
     dataset_mnist every 4:1:3 u 1:3 notitle with points ls 1,\
     dataset_mnist every 4:1:3 u 1:4 notitle with points ls 2,\
     dataset_mnist every 4:1:3 u 1:5 notitle with points ls 3,\
     dataset_mnist every 4:1:3 u 1:6 notitle with points ls 4,\
     dataset_mnist every 4:1:3 u 1:7 notitle with points ls 5,\
     1 / 0 title "Total Time" with linespoints ls 1,\
     2 / 0 title "nearest\\\_neighbors" with linespoints ls 2,\
     3 / 0 title "fuzzy\\\_simplicial\\\_set" with linespoints ls 3,\
     4 / 0 title "simplicial\\\_set\\\_embedding" with linespoints ls 4,\
     5 / 0 title "JIT Compiling" with linespoints ls 5

