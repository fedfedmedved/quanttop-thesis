import cProfile, pstats
import sys


s=pstats.Stats(sys.argv[1])
s.sort_stats('name')
s.print_stats('compiler.py|dispatcher.py|gpumap_.py|spectral.py|umap_.py')
