set key left top
unset colorbox

set view 70,20,1,1
set lmargin at screen 0.07
set rmargin at screen 0.94
set bmargin at screen 0.1
set tmargin at screen 0.97

set xlabel "N data points" offset 0,0.5
set ylabel "time in s" offset 3,0 rotate by 90

set ticslevel 0
#set xtics offset -3,-.5
#set ytics 768
#set ytics offset -0.8,-0.4
set y2tics
set mytics 10
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

#set xrange [10000:60000]
set yrange [16:256]
set y2range [16:256]

data_file='../../../data/umap/10_times/cifar_standard_error.dat'

set output 'deterministic_cifar.png'
plot data_file u 1:5:6 notitle with yerrorbars ls 1,\
     data_file u 1:5 notitle smooth csplines ls 1

set xrange [10000:70000]

data_file='../../../data/umap/10_times/mnist_standard_error.dat'

set output 'deterministic_mnist.png'
plot data_file u 1:5:6 notitle with yerrorbars ls 1,\
     data_file u 1:5 notitle smooth csplines ls 1

set yrange [16:180]
set y2range [16:1800]
set xrange [50000:500000]

data_file='../../../data/umap/10_times/google_news_standard_error.dat'

set output 'deterministic_google_news.png'
plot data_file u 1:5:6 notitle with yerrorbars ls 1,\
     data_file u 1:5 notitle smooth csplines ls 1


