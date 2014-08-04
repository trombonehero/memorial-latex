%
% Copyright (c) 2014, Jonathan Anderson <jonathan.anderson@mun.ca>.
% All rights reserved.
%
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are met:
%
% 1. Redistributions of source code must retain the above copyright notice,
% this list of conditions and the following disclaimer.
%
% 2. Redistributions in binary form must reproduce the above copyright notice,
% this list of conditions and the following disclaimer in the documentation
% and/or other materials provided with the distribution.
%
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
% ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
% LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
% CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
% SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
% INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
% CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
% ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
% POSSIBILITY OF SUCH DAMAGE.
%


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mun-lab}[2014/06/16 Lab handhout]

% Use the basic article structure.
\LoadClass{article}

\RequirePackage{mun-fonts}
\RequirePackage{mun-colour}

\RequirePackage{calc}
\RequirePackage{fancyhdr}
\RequirePackage[top=0.5in]{geometry}
\RequirePackage{graphicx}
\RequirePackage{hyperref}
\RequirePackage[framemethod=tikz]{mdframed}
\RequirePackage{parskip}
\RequirePackage{tabularx}
\RequirePackage{titlesec}

%
% Use the names "Engineering", "Faculty of Engineering and Applied Science"
% and "ENGI" in the appropriate places. Emit the Engineering-specific policy
% on academic integrity and professional conduct.
%
% Other Faculties and Departments should add similar class options here.
%
\newif\if@engineering
\@engineeringfalse
\DeclareOption{engineering}{\@engineeringtrue}

%
% Don't emit the "Lab Safety" section, even if there is a lab slot.
% This is for use with computer labs, which don't require PPE, etc. like
% oher labs (electrical, structural, chemical...).
%
\newif\if@safelabs
\@safelabsfalse
\DeclareOption{safelabs}{\@safelabstrue}

%
% Pass the remaining options to 'article'.
%
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\makeatletter


%
% Internal macros that represent key course information:
%
\newcommand{\@faculty}{Unknown Faculty}
\newcommand{\@shortfaculty}{Unknown}

\if@engineering
\renewcommand{\@faculty}{Faculty of Engineering and Applied Science}
\renewcommand{\@shortfaculty}{Engineering}
\fi

\newcommand{\@courseprefix}{ENGI}
\newcommand{\@coursename}{Short Name}
\newcommand{\@coursenumber}{XXXX}

\newcommand{\@labnumber}{XX}
\newcommand{\@labtitle}{An unnamed laboratory session}
\newcommand{\@labdate}{XX YYY ZZZZ}


%
% Externally-visible commands to define course information.  These are
% documented in the header comment at the top of this file, so if you add new
% commands, please also add documentation there!
%
\newcommand{\coursename}[1]{\renewcommand\@coursename{#1}}
\newcommand{\coursenumber}[1]{\renewcommand\@coursenumber{#1}}

\newcommand{\labnumber}[1]{\renewcommand\@labnumber{#1}}
\newcommand{\labtitle}[1]{\renewcommand\@labtitle{#1}}
\newcommand{\labdate}[1]{\renewcommand\@labdate{#1}}


%
% Page headers:
%
\pagestyle{fancy}
\setlength{\headheight}{.75in}
\renewcommand{\headrulewidth}{0.0pt}

\fancyhead{}
\fancyfoot{}

\fancyhead[L] {\neutralcolour \it \@shortfaculty~\@coursenumber:~\@coursename}
\fancyhead[R] {\headercolour \it Lab \@labnumber:~\@labtitle}
\fancyfoot[C] {\neutralcolour \bf \thepage}

\fancypagestyle{plain}{
\setlength{\headheight}{.25in}
\fancyhead {}
\fancyfoot[C] {\neutralcolour \bf \thepage}
}


%
% No paragraph indentation:
%
\setlength{\parindent}{0cm}


%
% Customised title:
%
\renewcommand{\arraystretch}{1}
\newcommand{\head}[1]{\textbf{\headercolour #1}}
\newcommand{\wide}[1]{\multicolumn{3}{p{0.85 \hsize}}{#1}}

\renewcommand{\maketitle}
{
  \thispagestyle{plain}

  \mbox{
    \parbox{3.25in}{
      \includegraphics[width=1.1in]{memorial} \vspace{6pt} \\
      {\neutralcolour \bf \hspace{5pt}\@faculty}
    }
    \parbox{2in}{
      \neutralcolour \bf
      Lab Handout \\
      \@courseprefix \@coursenumber \\
      \\
      \@labdate
    }
  }

  \vspace{.2in}

  {\bf \LARGE \headercolour Lab \@labnumber: \@labtitle}
}


%
% Section, etc. headings:
%
\titlespacing{\section}{0pt}{2em}{.75em}
\titlespacing{\subsection}{0pt}{1em}{0.25em}
\titlespacing{\subsubsection}{0pt}{0.5em}{0em}

\titleformat{name=\section}{\Large \bf \headercolour}{\thesection}{.5em}{}
\titleformat{name=\subsection}{\large \bf \headercolour}{\thesubsection}{.5em}{}
\titleformat{name=\subsubsection}{\bf \headercolour}{\thesubsubsection}{.5em}{}


\newenvironment{answer}
{
  \begin{mdframed}[frametitle=Answer,
    linecolor=MidnightBlue, backgroundcolor=AliceBlue!50,
    leftmargin=1em, rightmargin=1em,
    skipabove=1em, skipbelow=1em,
    outerlinewidth=1pt, roundcorner=.5em,
    frametitlefont={\normalfont\bfseries\color{MidnightBlue}},
  ]
}
{
  \end{mdframed}
}


\makeatother

\endinput
