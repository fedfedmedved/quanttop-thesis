# Abstract {-}

Visualization is important for humans to perceive, analyze and understand data.
Exploratory Data Analysis is essential in fields such as neural networks, deep-learning and data science in general.
Unfortunately data in these fields commonly has hundreds or thousands of dimensions, making classic visualization techniques unsuitable.
In recent years the dimensionality reduction algorithm t-SNE gained popularity.
It preserves local structures, allowing for meaningful visualizations of complex data.
UMAP is a very recent algorithm that challenges t-SNE as the status quo, providing better performance in both, execution time and quality of graphical results.
This thesis explores the functionality of UMAP and tries to improve its performance even further, by parallelizing it to execute on graphics cards, GPUs.
Profiling the GPU version, GPUMAP, shows speedups of two to four times.
These profilings were performed on common graphics hardware and can easily be improved with the usage of more current hardware.

\vspace{2cm}

Visualisierungen sind wichtig für Menschen um Daten zu betrachten, zu analysieren und zu verstehen.
Explorative Datenanalyse ist essentiell in Bereichen wie Deep-Learning, Neuronale Netze und Data Science allgemein.
Allerdings haben Daten in diesen Bereichen oft hunderte oder tausende von Dimensionen, was es klassischen Visualisierungstechniken unmöglich macht, sie darzustellen.
In den letzten Jahren gewann t-SNE an Beliebtheit, eine Methode zur Dimensionsreduktion.
Sie erhält lokale Strukturen, was eine aussagekräftige Visualisierung von komplexen Daten ermöglicht.
UMAP ist ein aktuell veröffentlichter Algorithmus, der t-SNE als den Status Quo infrage stellt.
Er bietet bessere grafische Ergebnis bei zugleich schnellerer Ausführung.
Diese Arbeit untersucht die Funktionalität von UMAP und versucht die Leistung noch weiter zu verbessern, durch eine Parallelisierung des Algorithmuses auf Grafikkarten, GPUs.
Messungen der GPU-Version GPUMAP zeigt zwei- bis vierfache Beschleuningungen.
Die Messungen wurden auf handelsüblicher Hardware durchgeführt und können leicht durch das Nutzen von aktueller Hardware verbessert werden.
