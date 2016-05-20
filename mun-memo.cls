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
\ProvidesClass{mun-memo}[2014/06/18 Memorial memo template]


% Use the basic article structure.
\LoadClass[12pt,letter]{article}

\RequirePackage{mun-colour}
\RequirePackage{mun-fonts}
\RequirePackage{mun-letterhead}

\RequirePackage{booktabs}
\RequirePackage{etoolbox}
\RequirePackage{fancyhdr}
\RequirePackage[top=0.5in,bottom=1in]{geometry}
\RequirePackage{graphicx}
\RequirePackage{hyperref}
\RequirePackage{longtable}
\RequirePackage{setspace}
\RequirePackage{tabularx}
\RequirePackage{titlesec}


\newif\if@ece
\@ecefalse
\DeclareOption{ece}{\@ecetrue}

\newif\if@midterm
\newif\if@final

\@midtermfalse
\@finaltrue

\DeclareOption{midterm}{\@midtermtrue \@finalfalse}


%
% We can use a conventional letter-style closing or a signature block
% as is expected on certain documents (e.g., declarations of research support).
%
\newif\if@signatureblock
\@signatureblockfalse
\DeclareOption{signatureblock}{\@signatureblocktrue}


%
% Pass the remaining options to 'article'.
%
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\makeatletter


\newcommand{\@address}{}
\newcommand{\address}[1]{\renewcommand{\@address}{#1}}

%
% Closing defaults to 'Sincerely'.
%
\newcommand{\@closing}{Sincerely,}
\newcommand{\closing}[1]{\renewcommand{\@closing}{#1}}


%
% Page headers:
%
\pagestyle{fancy}
\setlength{\headheight}{.75in}
\renewcommand{\headrulewidth}{0.0pt}

\fancyhead{}
\fancyfoot{}

%\fancyfoot[C] {\color{MUNClaret} \bf \thepage}

\fancypagestyle{plain}{
\setlength{\headheight}{.25in}
\fancyhead {}
%\fancyfoot[C] {\color{MUNClaret} \bf \thepage}
}


%
% No paragraph indentation:
%
\setlength{\parindent}{0cm}
\setlength{\parskip}{.5em}


%
% Allow treble-spacing (apparently popular in memos here):
%
\newcommand{\triplespacing}{%
  \setstretch {2.2}%  default
  \ifcase \@ptsize \relax % 10pt
    \setstretch {2.2}%
  \or % 11pt
    \setstretch {2.1}%
  \or % 12pt
    \setstretch {2.2}%
  \fi
}


\newcommand{\signatureline}[1][]{
  \parbox{2.6in}{
    \centering

    \ifx\\#1\\
      \vspace{2em}
    \else
      \vspace{4em}
    \fi

    \rule{2.5in}{1pt}

    \ifx\\#1\\
    \else
      \vspace{2em}
      \vspace{-\baselineskip}
      #1
    \fi
  }
}


\newcommand{\signatureblock}[1]{
  #1,
  \\[4em]
  \@author
}



%
% Customised title:
%
\renewcommand{\maketitle}
{
  \thispagestyle{plain}

  \letterhead

  \vspace{.5em}

  \if@signatureblock
  \else
    \@date
  \fi

  \vspace{.5em}

  \@address

  \ifdefempty{\@title}{}{
    \begin{center}
      \textbf{\@title}
    \end{center}
  }
}


%
% Customised signature section:
%
\AtEndDocument{
  \vspace{.25in}
  \if@signatureblock
    \begin{tabular}{ll}
      Signed:  &  \signatureline \\
      Date:    &  \signatureline
    \end{tabular}
  \else
    \@closing

    \vspace{.25in}

    \@author
  \fi
}


%
% Section, etc. headings:
%
\titlespacing{\section}{0pt}{.5em}{.25em}
\titlespacing{\subsection}{0pt}{.5em}{0.25em}
\titlespacing{\subsubsection}{0pt}{0.5em}{0em}

\titleformat{name=\section}{\Large \bf \color{MUNClaret}}{\thesection}{.5em}{}
\titleformat{name=\subsection}{\large \bf \color{MUNClaret}}{\thesubsection}{.5em}{}
\titleformat{name=\subsubsection}{\bf \color{MUNClaret}}{\thesubsubsection}{.5em}{}


\makeatother

\endinput
