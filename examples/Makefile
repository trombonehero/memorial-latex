.SUFFIXES: .md .pdf .tex

all: \
	courseoutline-example.pdf \
	mun-exam-example.pdf \
	mun-memo-example.pdf \
	mun-lab-example.pdf

clean:
	rm -f *.pdf


.md.tex:
	pandoc --smart --standalone --latex-engine=xelatex \
		--template=mun-memo-template.tex \
		$< --output=$@

.tex.pdf:
	latexmk -interaction=nonstopmode -pdf -xelatex $<
	latexmk -c $<
