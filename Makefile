.SUFFIXES: .md .pdf .tex

LATEX_MAKE=	latexmk -interaction=nonstopmode -pdf -xelatex
LATEX_CLEAN=	latexmk -c

all: courseoutline-example.pdf mun-exam-example.pdf mun-memo-example.pdf

clean:
	rm -f *.pdf


.md.tex:
	pandoc --smart --standalone --latex-engine=xelatex \
		--template=mun-memo-template.tex \
		$< --output=$@

.tex.pdf:
	$(LATEX_MAKE) $<
	$(LATEX_CLEAN) $<
