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


%
% The 'courseoutline' class generates course outlines as required at
% Memorial University of Newfoundland.  Many of its settings default to
% values appropriate for the Faculty of Engineering and Applied Science,
% but should be customisable for other faculties and departments via LaTeX
% class options.
%
% The class assumes that you have installed the commercial Adobe Garamond Pro
% files (licensed by the University) and are running under XeLaTeX.
%
% The class currently supports two options:
%
%   - engineering:  Use the names "Engineering", "Faculty of Engineering", etc.
%                   in the relevant places and emit the Faculty's policy on
%                   academic integrity ("Like Professional Engineers...").
%   - safelabs:     Don't emit a "Lab Safety" section even if a lab slot is
%                   declared with \lab. This is intended for use with
%                   computer labs (not electrical, structural, chemical labs).
%
% The following commands must be used to declare key information about the
% course (illustrated with example or default inputs):
%
% \coursename{Foundations of programming}
% \coursenumber{3891}
% \courseterm{Fall 2014}
%
% \instructor{Your name}
% \email{your.email@provider.com}
% \phone{(123) 456-7890 x9876}
% \office{EN1234}
% \officehours{Tue}{15:00}{16:00}
%
%
% The following commands are optional:
%
% \ta{The name(s) of TA(s), if any}
% \tamail{\{ta1,ta2\}@provider.com}
% \taphone{(123) 456-7890 x1234}
% \taoffice{EN4321}
% \tahours{Thu}{15:00}{16:00}
%
% \website{http://faculty.uni.com/course_website}      % no need for \url{}!
% \communication{other ways to communicate}
% \officialdescription{description from official (accreditation?) documents}
% \fulldescription{a longer, perhaps less official, description}
%
% \prerequisites{ENGI1020,MATH1000}
%
% \lecture{MWF}{9:00}{10:00}{EN2006}
% \tutorial{Tue}{14:00}{15:00}{EN2006}
% \lab{Thu}{14:00}{17:00}{EN3099}
%
%
% Based on this input, the class exports the following commands:
%
% \nameandnumber       % e.g. "Engineering 1000"
% \shortname           % e.g. "ENGI1000"
%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{courseoutline}[2014/05/27 University course outline]

% Use the basic article structure.
\LoadClass{article}

\RequirePackage{mun-fonts}
\RequirePackage{mun-colour}

\RequirePackage{fancyhdr}
\RequirePackage[top=0.5in]{geometry}
\RequirePackage{graphicx}
\RequirePackage{hyperref}
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
\newcommand{\@courseterm}{Spring XXXX}

\newcommand{\@name}{Dr No}
\newcommand{\@email}{dr.no@mun.ca}
\newcommand{\@phone}{864-XXXX}
\newcommand{\@office}{EN-XXXX}
\newcommand{\@officedays}{X}
\newcommand{\@officestart}{Y:00}
\newcommand{\@officefinish}{Z:00}

\newcommand{\@talabel}{}
\newcommand{\@ta}{}
\newcommand{\@tamail}{}
\newcommand{\@taphone}{}
\newcommand{\@taoffice}{}

\newcommand{\@calendar}{includes modules on foo, bar, baz and wibble.}

\newcommand{\@lecturedays}{MWF}
\newcommand{\@lecturestart}{X:00}
\newcommand{\@lecturefinish}{Y:00}
\newcommand{\@lectureroom}{EN-XXXX}

\newif\if@tutorial
\@tutorialfalse

\newif\if@labs
\@labsfalse

\newcommand{\@textbook}{\textendash}
\newcommand{\@references}{\textendash}


%
% Externally-visible commands to define course information.  These are
% documented in the header comment at the top of this file, so if you add new
% commands, please also add documentation there!
%
\newcommand{\coursename}[1]{\renewcommand\@coursename{#1}}
\newcommand{\coursenumber}[1]{\renewcommand\@coursenumber{#1}}
\newcommand{\courseterm}[1]{\renewcommand\@courseterm{#1}}

\newcommand{\instructor}[1]{\renewcommand\@name{#1}}
\newcommand{\email}[1]{\renewcommand\@email{#1}}
\newcommand{\phone}[1]{\renewcommand\@phone{#1}}
\newcommand{\office}[1]{\renewcommand\@office{#1}}
\newcommand{\officehours}[3]{
  \renewcommand\@officedays{#1}
  \renewcommand\@officestart{#2}
  \renewcommand\@officefinish{#3}
}

\newcommand{\ta}[1]{\renewcommand\@talabel{TA(s)}\renewcommand\@ta{#1}}
\newcommand{\tamail}[1]{\renewcommand\@tamail{#1}}
\newcommand{\taphone}[1]{\renewcommand\@taphone{#1}}
\newcommand{\taoffice}[1]{\renewcommand\@taoffice{#1}}
\newcommand{\tahours}[3]{
  \newcommand\@taofficedays{#1}
  \newcommand\@taofficestart{#2}
  \newcommand\@taofficefinish{#3}
}

\newcommand{\website}[1]{\newcommand\@website{#1}}
\newcommand{\communication}[1]{\newcommand\@othercomms{#1}}
\newcommand{\officialdescription}[1]{\renewcommand\@calendar{#1}}
\newcommand{\fulldescription}[1]{\newcommand\@description{#1}}
\newcommand{\prerequisites}[1]{\newcommand\@prereqs{#1}}

\newcommand{\lecture}[4]{
  \renewcommand\@lecturedays{#1}
  \renewcommand\@lecturestart{#2}
  \renewcommand\@lecturefinish{#3}
  \renewcommand\@lectureroom{#4}
}

\newcommand{\tutorial}[4]{
  \newcommand\@tutorialdays{#1}
  \newcommand\@tutorialstart{#2}
  \newcommand\@tutorialfinish{#3}
  \newcommand\@tutorialroom{#4}

  \@tutorialtrue
}

\newcommand{\lab}[4]{
  \newcommand\@labdays{#1}
  \newcommand\@labstart{#2}
  \newcommand\@labfinish{#3}
  \newcommand\@labroom{#4}

  \@labstrue
}


%
% Externally-visible outputs (also documented in the header comment):
%
\newcommand{\nameandnumber}{\@shortfaculty~\@coursenumber}
\newcommand{\shortname}{\nameandnumber:~\@coursename}

\newcommand{\@officehours}{
  \@officedays~\@officestart--\@officefinish
}

\newcommand{\@tahours}{
  \ifdefined\@taofficedays
    \@taofficedays~\@taofficestart--\@taofficefinish
  \fi
}
\newcommand{\lecturehours}{
  \@lecturedays~\@lecturestart--\@lecturefinish
}

\newcommand{\tutorialhours}{
  \ifdefined\@tutorialdays
    \@tutorialdays~\@tutorialstart--\@tutorialfinish
  \fi
}

\newcommand{\labhours}{
  \ifdefined\@labdays
    \@labdays~\@labstart--\@labfinish
  \fi
}


%
% Page headers:
%
\pagestyle{fancy}
\setlength{\headheight}{.75in}
\renewcommand{\headrulewidth}{0.0pt}

\fancyhead{}
\fancyfoot{}

\fancyhead[R] {\headercolour \it \shortname~\@courseterm}
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
      Course Outline \\
      \@courseprefix \@coursenumber \\
      \\
      \@courseterm
    }
  }

  \vspace{.2in}

  {\bf \LARGE \headercolour \shortname} \\

  \vspace{.1in}

  \begin{tabularx}{\textwidth}{lXlX}
    \head{Instructor}   & \@name         & \head{\@talabel} & \@ta         \\
                        & \@email        &              & \@tamail     \\
                        & \@phone        &              & \@taphone    \\
                        & \@office       &              & \@taoffice   \\
    \head{Office Hours} & \@officehours  &              & \@tahours

    \\[.5em]

    \ifdefined
               \@website     \head{Website}        & \wide{\url{\@website}}
               \\[.5em]
    \fi

    \ifdefined \@othercomms  \head{Communication}  & \wide{\@othercomms}  \\ \fi
                             \head{Calendar entry} & \wide{\@calendar}    \\
    \ifdefined \@description \head{Description}    & \wide{\@description} \\ \fi
    \ifdefined \@prereqs     \head{Prerequisite(s)}& \wide{\@prereqs}     \\ \fi

    \head{Schedule}
        & Lecture     & \lecturehours   & \@lectureroom   \\

      \if@tutorial
        & Tutorial    & \tutorialhours  & \@tutorialroom  \\ \fi

      \if@labs
        & Lab         & \labhours       & \@labroom       \\ \fi

    \head{Credit value} & 3 credit-hours                \\

    \head{Resources}  & Textbook         & \@textbook   \\
                      & References       & \@references \\
  \end{tabularx}
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


%
% Various bits of text that are common to many/all course outlines:
%
\newcommand{\engrintegrity}[0]{
}

\newcommand{\academicintegrity}[0]{
\if@engineering
\section{Academic Integrity and Professional Conduct}

The Faculty of Engineering and Applied Science has a Student Code of Conduct
which is available at \url{http://www.engr.mun.ca/policies/codeofconduct}
and reproduced here:

\begin{quotation}
Like Professional Engineers, engineering students are expected to behave in a
professional manner at all times. Students are encouraged to conduct
themselves in a manner consistent with the PEG-NL Code of Ethics.

Memorial University has two sets of rules which deal with inappropriate
behavior by students. The first set deals with academic offences such as
cheating while the other set deals with non academic offences such as
disruptive behavior in class.

Both sets of rules can be found in the University Calendar under Regulations.
It is strongly recommended that students read and follow these rules because
the penalties can be severe, the severest being expulsion from the University.
\end{quotation}
\else
\section{Academic Integrity}
Students are reminded of the Memorial University of Newfoundland Code,
which states:

\begin{quote}
All members of the Memorial University of Newfoundland Community, which includes
students, faculty, and staff, shall treat others with respect and fairness, be
responsible and honest, and uphold the highest standards of academic integrity.
\end{quote}

Academic misconduct is governed by section 6.11 of the University Calendar,
which begins:

\begin{quote}
Within the University community there is a collective responsibility to maintain
a high level of scholarly integrity. A student is expected to adhere to those
principles which constitute proper academic conduct. Academic misconduct cannot
be condoned or even appear to be condoned. A student has the responsibility to
know which actions, as described under Academic Offences, could be construed as
dishonest or improper. A student is reminded that for further guidance on proper
scholarly behaviour he/she should seek advice from his/her instructors and
faculty advisors.
\end{quote}
\fi
}


\newcommand{\boilerplate}[0]{
\academicintegrity


\if@safelabs
% The 'safelabs' option was passed to the class, elide the Lab Safety statement.
\else
\ifdefined\@labhours
\section{Lab Safety}
Students are expected to demonstrate awareness
of, and personal accountability for, safe laboratory conduct. Appropriate
personal protective equipment (PPE) must be worn (e.g. steel-toed shoes,
safety glasses, etc.) and safe work practices must be followed as indicated
for individual laboratories, materials and equipment. Students will
immediately report any concerns regarding safety to the teaching assistant,
staff technologist, and professor.
\fi
\fi


\section{Inclusion and Equity}
Students who require physical or
academic accommodations are encouraged to speak privately to the instructor so
that appropriate arrangements can be made to ensure your full participation in
the course. All conversations will remain confidential.

The university experience is enriched by the diversity of viewpoints, values,
and backgrounds that each class participant possesses. In order for this
course to encourage as much insightful and comprehensive discussion among
class participants as possible, there is an expectation that dialogue will be
collegial and respectful across disciplinary, cultural, and personal boundaries.


\section{Student Assistance}
Student Affairs and Services offers help
and support in a variety of areas, both academic and personal. More
information can be found at \url{http://www.mun.ca/student}.
}


\makeatother


\endinput
