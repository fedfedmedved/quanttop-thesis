target = -t latex
filters = -F pandoc-crossref -F pandoc-citeproc --lua-filter=makefiles/short-captions.lua
pandocflags = $(target) $(filters)

thesis: makefiles/config.yaml makefiles/references.yaml src/chapter*.md
	pandoc $(pandocflags) \
		-o thesis.pdf \
		--number-sections \
		-Mbook-class=false \
		makefiles/config.yaml \
		src/chapter*.md

makefiles/references.yaml: refs/*.bib
	pandoc-citeproc --bib2yaml $^ > $@

%.pdf: %.md
	pandoc $(target) -o $@ $<

all: thesis

.PHONY: all thesis
