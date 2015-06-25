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
\LoadClass[12pt]{article}

\RequirePackage{mun-fonts}
\RequirePackage{mun-colour}

\RequirePackage{fancyhdr}
\RequirePackage[top=0.5in]{geometry}
\RequirePackage{graphicx}
\RequirePackage{hyperref}
\RequirePackage{tabularx}
\RequirePackage{titlesec}


%
% Faculty- and Department-specific names and return addresses.
% Can be overridden with \department, \returnaddress and \website, but this is
% easier.
%
\newif\if@engineering
\@engineeringfalse
\DeclareOption{engineering}{\@engineeringtrue}

\newif\if@ece
\@ecefalse
\DeclareOption{ece}{\@ecetrue}


%
% Pass the remaining options to 'article'.
%
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\makeatletter


%
% Internal macros with key memo information:
%
\newcommand{\@department}{Unknown Faculty}
\newcommand{\@returnaddress}{Unspecified return address}
\newcommand{\@website}{www.mun.ca}

\newcommand{\@address}{no return address}


%
% Faculty- and Department-specific information (can still be overridden):
%
\if@engineering
  \renewcommand{\@department}{Faculty of Engineering and Applied Science}
  \renewcommand{\@returnaddress}{
    St. John's, NL~~Canada~~A1B~3X5 \\
    Tel: 709~864~8812~Fax: 709~864~4042
  }
  \renewcommand{\@website}{www.engr.mun.ca}
\fi

\if@ece
  \renewcommand{\@department}{Department of Electrical and Computer Engineering}
  \renewcommand{\@returnaddress}{
    Faculty of Engineering and Applied Science \\
    St. John's, NL~~~Canada~~~A1B~3X5 \\
    Tel: 709~864~8177~~~~Fax: 709~864~4042
  }
  \renewcommand{\@website}{www.engr.mun.ca}
\fi



\newcommand{\department}[1]{\renewcommand{\@department}{#1}}
\newcommand{\returnaddress}[1]{\renewcommand{\@returnaddress}{#1}}
\newcommand{\website}[1]{\renewcommand{\@website}{#1}}
\newcommand{\address}[1]{\renewcommand{\@address}{#1}}


%
% Page headers:
%
\pagestyle{fancy}
\setlength{\headheight}{.75in}
\renewcommand{\headrulewidth}{0.0pt}

\fancyhead{}
\fancyfoot{}

\fancyhead[R] {\color{MUNClaret} \it \shortname~\@courseterm}
\fancyfoot[C] {\color{MUNClaret} \bf \thepage}

\fancypagestyle{plain}{
\setlength{\headheight}{.25in}
\fancyhead {}
\fancyfoot[C] {\color{MUNClaret} \bf \thepage}
}


%
% No paragraph indentation:
%
\setlength{\parindent}{0cm}


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
  \parbox{2.1in}{
    \centering

    \ifx\\#1\\
      \vspace{1em}
    \else
      \vspace{2em}
    \fi

    \rule{2in}{1pt}

    \ifx\\#1\\
    \else
      \vspace{-1.8em}
      #1
    \fi
  }
}



%
% Customised title:
%
\renewcommand{\maketitle}
{
  \thispagestyle{plain}

  \includegraphics[width=0.875in]{memorial} \vspace{6pt} \\
  \textcolor{MUNGrey}{
    \hspace{4pt}{\fontsize{10pt}{12pt}\selectfont \bf \@department}
    \\
    \vspace{1pt}
    \\
    \mbox{
      \hspace{-2pt}
      \parbox{\textwidth}{
        \sf
        \fontsize{8pt}{10.25pt}\selectfont
        \@returnaddress
        \\
        {\color{MUNClaret} \@website}
      }
    }
  }

  \vspace{.5em}

  \@date

  \vspace{.5em}

  \@address

  \vspace{.25in}

  \begin{center}
    {\MakeUppercase{\@title}}
  \end{center}

  \vspace{.25in}
}


%
% Section, etc. headings:
%
\titlespacing{\section}{0pt}{2em}{.75em}
\titlespacing{\subsection}{0pt}{1em}{0.25em}
\titlespacing{\subsubsection}{0pt}{0.5em}{0em}

\titleformat{name=\section}{\Large \bf \color{MUNClaret}}{\thesection}{.5em}{}
\titleformat{name=\subsection}{\large \bf \color{MUNClaret}}{\thesubsection}{.5em}{}
\titleformat{name=\subsubsection}{\bf \color{MUNClaret}}{\thesubsubsection}{.5em}{}


\makeatother

\endinput
