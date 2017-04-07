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
\ProvidesClass{mun-exam}[2014/10/10 Exam]

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

\newif\if@ece
\@ecefalse
\DeclareOption{ece}{\@ecetrue}

\newif\if@midterm
\newif\if@final

\@midtermfalse
\@finaltrue

\DeclareOption{midterm}{\@midtermtrue \@finalfalse}

\newif\ifblackandwhite
\blackandwhitefalse
\DeclareOption{bw}{\blackandwhitetrue}


%
% Pass the remaining options to 'exam'.
%
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{exam}}
\ProcessOptions\relax

\RequirePackage{fancyhdr}

\LoadClass[addpoints]{exam}

\RequirePackage{mun-fonts}
\RequirePackage{mun-colour}

\RequirePackage{amsmath}
\RequirePackage{calc}
\RequirePackage[top=0.5in, left=1in, right=1in, bottom=.5in, includeheadfoot]{geometry}
\RequirePackage{graphicx}
\RequirePackage{hyperref}
\RequirePackage{ifthen}
\RequirePackage{listings}
\RequirePackage[framemethod=tikz]{mdframed}
\RequirePackageWithOptions{mun-letterhead}
\RequirePackage{parskip}
\RequirePackage{setspace}
\RequirePackage{siunitx}
\RequirePackage{tabularx}
\RequirePackage{titlesec}
\RequirePackage{verbatim}

\makeatletter


\newcommand{\@courseprefix}{ENGI}
\newcommand{\@coursename}{Short Name}
\newcommand{\@coursenumber}{XXXX}
\newcommand{\@examdate}{Unspecified date}
\newcommand{\@instructions}{none}

%
% The kind of exam (mid-term, final, etc.):
%
\if@midterm
\newcommand{\@examtype}{Mid-term}
\fi

\if@final
\newcommand{\@examtype}{Final}
\fi


%
% Externally-visible commands to define course information.  These are
% documented in the header comment at the top of this file, so if you add new
% commands, please also add documentation there!
%
\newcommand{\coursename}[1]{\renewcommand\@coursename{#1}}
\newcommand{\coursenumber}[1]{\renewcommand\@coursenumber{#1}}
\newcommand{\examdate}[1]{\renewcommand\@examdate{#1}}
\newcommand{\instructions}[1]{\renewcommand\@instructions{#1}}


%
% Header/footer formatting
%
\pagestyle{fancy}

\setlength{\headsep}{1em}
\fancyhead[RO]{Student ID: \rule[-3pt]{1.5in}{.5pt}}

\raggedbottom



%
% No paragraph indentation:
%
\setlength{\parindent}{0cm}


%
% Colouring:
%
\ifblackandwhite
\renewcommand{\headercolour}{}
\renewcommand{\neutralcolour}{}
\fi



%
% Section, etc. headings:
%
\titlespacing{\section}{0pt}{.25em}{.25em}
\titlespacing{\subsection}{0pt}{1em}{0.25em}
\titlespacing{\subsubsection}{0pt}{1em}{0em}

\titleformat{name=\section}{\Large \bf \headercolour}{\thesection}{.5em}{}
\titleformat{name=\subsection}{\large \bf \headercolour}{\thesubsection}{.5em}{}
\titleformat{name=\subsubsection}{\bf \headercolour}{\thesubsubsection}{.5em}{}


%
% Customised title:
%
\renewcommand{\arraystretch}{1}
\newcommand{\head}[1]{\textbf{\headercolour #1}}
\newcommand{\wide}[1]{\multicolumn{3}{p{0.85 \hsize}}{#1}}

\renewcommand{\maketitle}
{
  \thispagestyle{empty}

  \mbox{
    \parbox{3.25in}{\letterhead}
    \parbox{2.5in}{
      \neutralcolour
      \textbf{\@courseprefix \@coursenumber:} \@coursename \\
      \textbf{\@examtype~exam} \\
      \textbf{\@examdate}
      \vspace{2.25em} \\
      \makebox[2.5in]{Name:\enspace\hrulefill}
      \vspace{-1.2em} \\
      \makebox[2.5in]{Student ID:\enspace\hrulefill}
    }
  }

  \vspace{.2in}

  \if@final

    {\bf \LARGE \headercolour \@courseprefix \@coursenumber: \@coursename}

    \section*{\@examtype~exam}

    \begin{center}
      \gradetable[v][questions]
    \end{center}

    \section*{Instructions}
    \parbox{\textwidth}{
      \begin{doublespace}
        \@instructions
      \end{doublespace}
    }

    \pagebreak
    \makebox[\textwidth][c]{%
      \frame{\includegraphics[trim={4cm 0 0 0},clip,width=7.5in]{guilloche}}%
    }
    \clearpage
  \else

    \section*{Instructions}
    \parbox{\textwidth}{
      \begin{doublespace}
        \@instructions
      \end{doublespace}
    }
    \\
    \begin{center}
      \gradetable[h][questions]
    \end{center}

    \pagebreak
    \makebox[\textwidth][c]{%
      \frame{\includegraphics[trim={4cm 0 0 0},clip,height=9in,width=7.5in]{guilloche}}%
    }
  \fi

  \thispagestyle{empty}
  \pagebreak
  \setcounter{page}{1}
}


%
% Show question points in the right margin with brackets around them.
%
\extrawidth{-.5in}
\pointsinrightmargin
\boxedpoints
\totalformat{\textbf{[\totalpoints]}}


\makeatother

\endinput
