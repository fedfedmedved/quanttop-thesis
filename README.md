# Quantum topology exposition paper
This repository contains all sources of the master thesis with the stated title.
The Markdown sources can be found in the `src/` folder.
The scripts used to create graphics and profilings are in the `scripts/` folder.

The repository of GPUMAP, the implementation described in the thesis can be found
[here](https://github.com/p3732/gpumap).

The thesis is based on [this template](https://github.com/fsphys/thesisvorlage-markdown).

## Building the Thesis
The following packages are required:

* make
* [Tex-Live](https://tug.org/texlive/)
** texlive-latex-base, texlive-latex-extra, texlive-science


* [Pandoc](https://pandoc.org)
* [pandoc-crossref](https://github.com/lierdakil/pandoc-crossref)
* [pandoc-citeproc](https://github.com/jgm/pandoc-citeproc)
* [pandoc-theorem](https://github.com/sliminality/pandoc-theorem)

(this last one takes a while to install)

If all dependencies are installed, a simple `make` in the repository folder will
create the `thesis.pdf` file.

