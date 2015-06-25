# LaTeX classes for Memorial University

Here are some LaTeX bits that might be useful to instructors (or possibly
even students) at [Memorial University of Newfoundland](http://www.mun.ca).


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
departments: search for ```\if@engineering``` in
[courseoutline.cls](courseoutline.cls).

This template requires the ```mathdesign``` package and ```urw-garamond```
fonts, neither of which is part of the default TeXLive installation.
See [mathdesign on CTAN](http://www.ctan.org/tex-archive/fonts/mathdesign/)
for details on installing the fonts and package.

A complete example is provided in
[courseoutline-example.tex](courseoutline-example.tex).


## Lab

[mun-lab.cls](mun-lab.cls) is a class for writing lab
procedures with nice headers and an `answer` environment for TA grading.
I use it like this:

```latex
\documentclass[answerkey,engineering,twoside]{mun-lab}

\coursename{Advanced Programming}
\coursenumber{3891}

\labnumber{0}
\labtitle{Version control}
\labdate{10 Sep 2014}

\usepackage{listings}

\usepackage{tikz}
\usetikzlibrary{calc}

% ...

\begin{document}
\maketitle

% ...


\section{Procedure}

\newcommand{\partner}[2]{\item[Partner #1] \hfill \\ #2}

As a pair of lab partners, follow the instructions given below.
You may work on the same computer or separate computers, but follow the
instructions together, in order: you both need to observe each other's work.
Whenever you encounter the text \lstinline{<<output>>} in the instructions,
make a note of the program output you see on the console.
These workings should go in your lab report.

\begin{description}

	\partner{A}{Check out your assigned Subversion repository.}
\begin{lstlisting}[style=console]
...
\end{lstlisting}

	\begin{answer}
\begin{lstlisting}[style=console]
Checked out revision 0.
\end{lstlisting}
	\end{answer}

\end{description}

\end{document}
```



## Memo

[mun-memo.cls](mun-memo.cls) is a very simple memo class
that includes a `\signatureline` command.
An example of what I use it for:

```latex
\documentclass[ece]{mun-memo}

\usepackage{setspace}

\title{Declaration of Research Support}


\begin{document}
\maketitle

\triplespacing

I, \signatureline[(supervisor)], certify that
all necessary research equipment (including software and networking),
materials and supplies (including chemicals), and
other equipment and resources will be made available to the student
to carry out the proposed research.

\vspace{1in}

\begin{tabular}{ll}
  Signed:  &  \signatureline \\
  Date:    &  \signatureline
\end{tabular}

\end{document}
```
