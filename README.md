# Memorial University
## Course outline template

This is a template for course outlines as required by
[section 6.6 of Memorial's Calendar](http://www.mun.ca/regoff/calendar/sectionNo=REGS-0601).
It is currently targeted at Engineering courses, according to the original
author's need, but is designed to be reusable by other faculties and
departments: search for ```\if@engineering``` in
[courseoutline.cls](courseoutline.cls).

A complete example is provided in [example.tex](example.tex), but the
basic usage is as follows:

```latex
\documentclass[engineering]{courseoutline}

\coursename{Fundamentals of Widgets}
\coursenumber{1000}
\courseterm{Fall 2014}
\prerequisites{MATH1000}

\officialdescription{
Engineering 1000 Fundamentals of Widgets provides first-year students
with introductory exposure to the analysis and design of widgets.
Topics include widget geometry, statics, dynamics and the application
of electricity to non-conductive widgets.
}

\website{http://www.engr.mun.ca/teaching/ENGI1000}

\instructor{Your name}
\email{your.email@provider.com}
\phone{864-1234}
\office{EN1234}
\officehours{Tue 15:00--16:00}

\ta{Ingrid M Engineer}
\tamail{imeng@mun.ca}
\taphone{(123) 456-7890 x9876}
\taoffice{EN1235}
\tahours{Thu 15:00--16:00}

\lecture{MWF X:00--Y:00}{EN-2001}
\tutorial{Tue 14:00--15:00}{EN-2002}
\lab{Fri 14:00--17:00}{EN-2003}

\begin{document}

\maketitle

\section{Major Topics}
\dots

\section{Learning Outcomes}
\dots

\section{Assessment}
\dots

\boilerplate

\end{document}
```
