# LaTeX classes for Memorial University

Here are some LaTeX bits that might be useful to instructors (or possibly
even students) at [Memorial University of Newfoundland](http://www.mun.ca).

## Common options

All of the document classes below (course outline, exam, lab, memo)
accept a few common options:

`bw`
: Use black-and-white text and logo.

`engineering`
: Use "Faculty of Engineering and Applied Science" under Memorial logo.
  Implies "ENGI" course numbers (where applicable).

`ece`
: Use "Department of Electrical and Computer Engineering" under logo.
  Implies "ENGI" course numbers (where applicable).


## Colours and fonts

[mun-colour.sty](mun-colour.sty)
provides official Memorial colours
(`\color{MUNClaret}` and `\color{MUNGrey}`)
in CMYK.
[mun-fonts.sty](mun-fonts.sty)
sets fonts to the official MUN fonts
(Adobe Garamond Pro for serif, with Semibold as `bf`,
plus Avenir Light for sans-serif)
**but** this requires `xelatex` rather than `latex`.
There are workarounds for Adobe Garamond Pro Semibold with "normal" `latex`,
but, well, life's too short.


## Course outline

[courseoutline.cls](courseoutline.cls)
is a class for course outlines as required by
[section 6.6 of Memorial's Calendar](http://www.mun.ca/regoff/calendar/sectionNo=REGS-0601).
It is currently targeted at Engineering courses, according to the original
author's need, but is designed to be reusable by other faculties and
departments: search for `\if@engineering` in
[courseoutline.cls](courseoutline.cls).

The class accepts the `safelabs` option, which disables the standard
lab safety text (PPE, "safe work practices", etc.).
I use this option for my courses, where "the lab" is a computer lab.

A complete example is provided in
[courseoutline-example.tex](courseoutline-example.tex).


## Exam

[mun-exam.cls](mun-exam.cls) is a class for mid-term tests and final exams.
It accepts standard paper size options (e.g., `letterpaper` and `legalpaper`).
It also accepts the `midterm` option to differentiate between mid-term tests
and final exams.
The former attempts to conserve space at the beginning of the exam, though it
does include a horizontal "points for each question" block.
The latter uses a full cover page with a vertical points block
and `\cleardoublepage`.


## Lab

[mun-lab.cls](mun-lab.cls) is a class for writing lab
procedures with nice headers and an `answer` environment for TA grading.
It accepts the `answerkey` option for producing answer keys.
I use it like this:

```latex
\documentclass[answerkey,engineering,twoside]{mun-lab}

\coursename{Production of Widgets}
\coursenumber{1000}

\labnumber{0}
\labtitle{Widget polishing}
\labdate{10 Sep 2014}

% ...

\begin{document}
\maketitle

% ...


\section{Procedure}

\begin{enumerate}

\item Turn on the widget polisher.
\item Set the desired polish level to ``glossy''.
\item ???
\item \textbf{Question:} how many microns of widget were removed?
	\begin{answer}
	All of them!
	\end{answer}

\end{description}

\end{document}
```



## Memo

[mun-memo.cls](mun-memo.cls) is a very simple memo class
that includes a `\signatureline` command.
Combined with [pandoc](http://pandoc.org) and
[mun-memo-template.tex](mun-memo-template.tex), you can do quite neat things
like generate formatted letters from Markdown files
(see my [Makefile](Makefile#L12) for an example of this).
