target = -t latex
filters = -F pandoc-crossref -F pandoc-citeproc --lua-filter=makefiles/short-captions.lua
pandocflags = $(target) $(filters)


thesis: makefiles/config.yaml makefiles/references.yaml chapter*.md appendix*.md
	pandoc $(pandocflags) \
		-o thesis.pdf \
		--number-sections \
		makefiles/config.yaml \
		chapter*.md \
		appendix*.md

makefiles/references.yaml: refs/*.bib
	pandoc-citeproc --bib2yaml $^ > $@

%.pdf: %.md
	pandoc $(target) -o $@ $<

all: thesis

.PHONY: all thesis
