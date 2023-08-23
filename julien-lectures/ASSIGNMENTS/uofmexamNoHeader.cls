%
% This package (c) 2005-2018 Dave Gabrielson <dave.gabrielson@umanitoba.ca>
%

\ProvidesClass{uofmexam}[2018/10/09 v4.5 uofm exam class]
\NeedsTeXFormat{LaTeX2e}[1998/12/01]


\RequirePackage{xkeyval}
\RequirePackage{ifthen}

\newcommand{\examopt@school}{\uppercase{University of Manitoba}}
\newcommand{\examopt@type}{}
\newcommand{\examopt@coursenumber}{coursenumber=REQUIRED}
\newcommand{\examopt@coursetitle}{}
\newcommand{\examopt@crn}{}
\newcommand{\examopt@date}{date=REQUIRED}
\newcommand{\examopt@time}{time=REQUIRED}
\newcommand{\examopt@duration}{duration=REQUIRED}
\newcommand{\examopt@examiner}{}
\newcommand{\examopt@geometry}{margin=1in,legalpaper}
\newcommand{\examopt@crowdmarkstyle}{simplex}


\newboolean{examopt@crowdmark}
\setboolean{examopt@crowdmark}{false}

\newboolean{LeftAlignedSignatureBox}
\setboolean{LeftAlignedSignatureBox}{false}

\newboolean{CompactSignatureBox}
\setboolean{CompactSignatureBox}{false}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\DeclareOptionX<ExamInfo>{school}%
	{\renewcommand{\examopt@school}{#1}}

\DeclareOptionX<ExamInfo>{type}%
	{\renewcommand{\examopt@type}{#1}}

\DeclareOptionX<ExamInfo>{coursenumber}%
	{\renewcommand{\examopt@coursenumber}{#1}}

\DeclareOptionX<ExamInfo>{coursetitle}%
	{\renewcommand{\examopt@coursetitle}{#1}}

\DeclareOptionX<ExamInfo>{crn}%
	{\renewcommand{\examopt@crn}{#1}}

\DeclareOptionX<ExamInfo>{date}%
	{\renewcommand{\examopt@date}{#1}}

\DeclareOptionX<ExamInfo>{time}%
	{\renewcommand{\examopt@time}{#1}}

\DeclareOptionX<ExamInfo>{duration}%
	{\renewcommand{\examopt@duration}{#1}}

\DeclareOptionX<ExamInfo>{examiner}%
	{\renewcommand{\examopt@examiner}{#1}}

\DeclareOptionX<ExamInfo>{crowdmark}%
	{
	    \setboolean{examopt@crowdmark}{true}%
	    \ClassInfo{uofmexam.cls}{Enabling CROWDMARK formatting}%
	    \renewcommand{\examopt@crowdmarkstyle}{#1}%
	    \ifthenelse{\equal{\examopt@crowdmarkstyle}{simplex} \OR \equal{\examopt@crowdmarkstyle}{}}{%
	        \renewcommand{\examopt@crowdmarkstyle}{simplex}
	        \ClassInfo{uofmexam.cls}{Enabling CROWDMARK simplex}%
	    }{%
            \ifthenelse{\equal{\examopt@crowdmarkstyle}{duplex}}{%
                \ClassInfo{uofmexam.cls}{Enabling CROWDMARK duplex}%
            }{%
                \ClassError{uofmexam.cls}{invalid crowdmark style}{The only support crowdmark options are crowdmark=simplex and crowdmark=duplex}
            }%
	    }%
	}



\DeclareOptionX*{%
	\PassOptionsToClass{\CurrentOption}{exam}%
}

\ProcessOptionsX<ExamInfo>
\LoadClassWithOptions{exam}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\examinfo}[1]{\ExecuteOptionsX<ExamInfo>{#1}}
\@onlypreamble\examinfo

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{geometry}
\RequirePackage{graphicx}
\RequirePackage{type1cm}
\RequirePackage{relsize}
\RequirePackage{enumerate}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{multicol}
\RequirePackage{longtable}
\RequirePackage{tabulary}
\RequirePackage{tikz}
\RequirePackage{cancel}
\RequirePackage{microtype}

\@ifclasslater{exam}{2017/12/17}{%
	\typeout{Newer exam class --- loading framed package.}
	\RequirePackage{framed}
}{%
	\typeout{Older exam class --- framed already defined.}
}

\expandafter\geometry\expandafter{\examopt@geometry}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\schoolformat}{\bfseries}
\newcommand{\school}{\schoolformat{}\examopt@school{}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FORMATTING ("pay no attention to the man behind the curtain...")



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Exam formatting
% Using a different format for choices:
\renewcommand{\thechoice}{\Alph{choice}}	% \arabic, \alph, \Alph, \roman, \Roman, \greeknum
\renewcommand{\choicelabel}{(\thechoice)}	% how \thechoice appears


\renewcommand{\choiceshook}{
	\setlength{\topsep}{2ex}	% extra line before each choices environ.
	\setlength{\leftmargin}{2em}	% don't indent so much
	}


\renewcommand{\questionshook}{\setlength{\itemsep}{1cm}}	% extra space between each question
	% NOTE: this does not work with rubber spaces, i.e, \fill, or \stretch{n}
	%	to equally distribute the blank space between questions, put
	%	"\vfill" between each question.


\renewcommand{\CorrectChoiceEmphasis}{\bfseries}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Aligned oneparchoices:
%        Use the environment \begin{onelinechoices}{length}  ... \end{onelinechoices}
%        or \begin{lchoices} ... \end{lchoices}                to use the default length (3.2 inch)
%        and use "\lchoice" instead of "\choice"
%        NOTE: this environment has an explicit assumption of exactly 5 choices AND NO MORE.

\newlength{\onelinechoicesindent}
\setlength{\onelinechoicesindent}{0.5em}        % set to 0em for no indentation

\newenvironment{onelinechoices}[1]{%

        \begin{oneparchoices}%
        \begin{tabbing}%
        \hspace*{\onelinechoicesindent}%
        \=\hspace*{0.86#1}\=\hspace*{#1}\=\hspace*{#1}\=\hspace*{#1}\=\hspace*{#1}\= \kill %
}{%
        \end{tabbing} %
        \end{oneparchoices} %
}


\newcommand{\lchoice}{\>\choice}
\newcommand{\lCorrectChoice}{\>
        \ifprintanswers
        \CorrectChoiceEmphasis
        \fi
        \choice
}
        % BUG: Just using \CorrectChoice does not work.


\newlength{\onelinechoicesamount}
\setlength{\onelinechoicesamount}{3.2cm}        % A good number is between 2.75cm and 3.25cm


\newenvironment{lchoices}{
\par\noindent
\begin{onelinechoices}{\onelinechoicesamount}
}{
\end{onelinechoices}
}


\cellwidth{2cm}
\pointsinmargin
\bracketedpoints
\addpoints

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Header
%   The registrars office specifies: course code, number, and section;
%   the date, time, and length of the final exam; and numbered pages.
%   So required is Date & Time, Duration, Dept & Course Number %
%   (and section number; if not multisection); numbered pages.

% TODO: Consider using xstring with these.
\newcommand{\headerlabeldate}{DATE: }
\newcommand{\headerlabeltime}{TIME: }
\newcommand{\headerlabeldatetime}{DATE \& TIME: }
\newcommand{\headerlabelcoursenumber}{COURSE: }
\newcommand{\headerlabelcrn}{CRN: }
\newcommand{\headerlabelschool}{}
\newcommand{\headerlabeltype}{}
\newcommand{\headerlabelduration}{DURATION: }
\newcommand{\headerlabelpage}{PAGE: }
\newcommand{\headerlabelpagesep}{~of~}
\newcommand{\headerlabelexaminer}{EXAMINER: }



\headrule
\footrule
\coverheadrule
\coverfootrule

\newlength{\examhdr@left@drop}
\setlength{\examhdr@left@drop}{-3\baselineskip}%
\newlength{\examhdr@right@drop}
\setlength{\examhdr@right@drop}{-3\baselineskip}%



\newcommand{\examheader@left}%
	{%
		\raisebox{\examhdr@left@drop}{\vbox{%
		\mbox{} \\
		\headerlabelcoursenumber\examopt@coursenumber \\
		\ifthenelse{\equal{\examopt@crn}{}}{}{\headerlabelcrn\examopt@crn \\}
		\headerlabeldatetime\examopt@date, \examopt@time \\
		\mbox{}
		}}%
	}

\newcommand{\examheader@center}%
	{%
		\headerlabelschool\school
		\ifthenelse{\equal{\examopt@type}{}}{}{\linebreak \headerlabeltype\examopt@type}
	}

\newcommand{\examheader@right}%
	{%
		\raisebox{\examhdr@right@drop}{\vbox{%
		\mbox{}
		\headerlabelduration\examopt@duration \\
		\ifthenelse{\equal{\examopt@examiner}{}}{}{\headerlabelexaminer\examopt@examiner \\}
		\headerlabelpage\thepage\headerlabelpagesep\numpages \\
		\mbox{}
		}}%
	}


\newcommand*\@docrowdmarkhead{%
  \def\@oddhead{%
    \typeout{Doing CROWDMARK header}
      \vbox to \headheight{%
        \vss
        \hbox to \textwidth{%
            \ifthenelse{\equal{\examopt@crowdmarkstyle}{simplex}}{%
                \normalfont\rlap{\parbox[b]{\textwidth}{\raggedright\@lhead\strut}}%
                \hss\parbox[b]{\textwidth}{\centering\@chead\strut}\hss
                \llap{\parbox[b]{\textwidth}{\raggedleft\@rhead\strut}}%
                \makebox[1in]{}
            }{% else "duplex"
                \oddeven{%
                    \normalfont\rlap{\parbox[b]{\textwidth}{\raggedright\@lhead\strut}}%
                    \hss\parbox[b]{\textwidth}{\centering\@chead\strut}\hss
                    \llap{\parbox[b]{\textwidth}{\raggedleft\@rhead\strut}}%
                    \makebox[1in]{}
                }{%
                    \makebox[1in]{}
                    \normalfont\rlap{\parbox[b]{\textwidth}{\raggedright\@lhead\strut}}%
                    \hss\parbox[b]{\textwidth}{\centering\@chead\strut}\hss
                    \llap{\parbox[b]{\textwidth}{\raggedleft\@rhead\strut}}%
                }
            }
        }% hbox
        \if@headrule
          \hrule
        \else
          % an invisible hrule, to keep positioning constant:
          \hrule width 0pt
        \fi
      }% vbox
  }% @oddhead
  \let\@evenhead=\@oddhead
}


\newcommand*\@docrowdmarkfoot{%
    \@nofoot
}

\newcommand*\ps@crowdmark{%
  \@docrowdmarkhead
  \@docrowdmarkfoot
}



%\header{\examheader@left}%
%	{\examheader@center}%
%	{\examheader@right}
\header{}{}{}

% No footer:
\footer{}{}{}


\AtBeginDocument{%
    \ifthenelse{\boolean{examopt@crowdmark}}{%
        % Crowdmark style
        \typeout{Enabling CROWDMARK pagestyle}
        \coverextraheadheight{0.67in}
        \extraheadheight{0.67in}
        \renewcommand{\examheader@left}%
            {%
                \raisebox{-1.75in}{\vbox{%
                \ifthenelse{\equal{\examopt@crowdmarkstyle}{simplex}}{%
                    {\headerlabelschool\school} \\
                    \ifthenelse{\equal{\examopt@type}{}}{}{\textbf{\headerlabeltype\examopt@type} \\}
                    \headerlabelcoursenumber\examopt@coursenumber \\
                    \headerlabeldatetime\examopt@date, \examopt@time \\
                    \ifthenelse{\equal{\examopt@crn}{}}{}{\headerlabelcrn\examopt@crn \\}
                    \headerlabelduration\examopt@duration \\
                }{% else "duplex"
                    \oddeven{%
                        {\headerlabelschool\school} \\
                        \headerlabelcoursenumber\examopt@coursenumber \\
                        \headerlabeldatetime\examopt@date, \examopt@time \\
                        \ifthenelse{\equal{\examopt@crn}{}}{}{\headerlabelcrn\examopt@crn \\}
                        \ifthenelse{\equal{\examopt@type}{}}{}{\headerlabeltype\examopt@type \\}
                        \headerlabelduration\examopt@duration \\
                    }{%
                        %\headerlabelpage\thepage\headerlabelpagesep\numpages \\
                    }
                }
                \mbox{}
                }}%
            }
        \renewcommand{\examheader@center}%
            {%
                \mbox{}
            }
        \renewcommand{\examheader@right}%
            {%
                \raisebox{-1.75in}{\vbox{%
                \mbox{}
                \ifthenelse{\equal{\examopt@crowdmarkstyle}{simplex}}{%
                }{% else "duplex"
                    \oddeven{%
                        %\headerlabelpage\thepage\headerlabelpagesep\numpages \\
                    }{%
                        {\headerlabelschool\school} \\
                        \headerlabelcoursenumber\examopt@coursenumber \\
                        \ifthenelse{\equal{\examopt@crn}{}}{}{\headerlabelcrn\examopt@crn \\}
                        \ifthenelse{\equal{\examopt@type}{}}{}{\headerlabeltype\examopt@type \\}
                        \headerlabeldatetime\examopt@date, \examopt@time \\
                        \headerlabelduration\examopt@duration \\
                    }
                }
                \ifthenelse{\equal{\examopt@examiner}{}}{}{\headerlabelexaminer\examopt@examiner \\}
                \mbox{}
                }}%
            }
        \pagestyle{crowdmark}

    }{%
        % Normal style
        \typeout{Enabling NORMAL pagestyle}
        \coverextraheadheight{10ex}
        \extraheadheight{10ex}
        \pagestyle{head}

        % Adjust headers elements based on included optional items.
        \ifthenelse{\equal{\examopt@crn}{}}{}{%
                \addtolength{\examhdr@left@drop}{-\baselineskip}%
            }%
        \ifthenelse{\equal{\examopt@examiner}{}}{}{%
                \addtolength{\examhdr@right@drop}{-\baselineskip}%
            }%


    } % end of \ifthenelse{\boolean{examopt@crowdmark}}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Environment: Instructions

\newenvironment{instructions}
	{%
		\begin{center}
		    \begin{LARGE}
		        \underline{\textbf{INSTRUCTIONS}}
		    \end{LARGE}
		\end{center}


		\begin{enumerate}[I.]
	}%
	{%
		\end{enumerate}

		\bigskip
	}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Environment: gradetableinstructions

\newenvironment{gradetableinstructions}
	{%
\vspace{2em plus 1em minus 0.75em}
\noindent
\begin{tabular}{lr}
\hspace*{-\tabcolsep}
\begin{minipage}{0.61\textwidth}
    \begin{flushleft}
		\begin{center}
		    \begin{LARGE}
		        \underline{\textbf{INSTRUCTIONS}}
		    \end{LARGE}
		\end{center}
		\begin{enumerate}[I.]
            \setlength{\itemsep}{0.5em plus 0.5em minus 0.5em}
            \setlength{\labelsep}{0.4em}
            \setlength{\labelwidth}{0em}
            \setlength{\parsep}{0ex}
            \setlength{\topsep}{0.5em plus 0.5em minus 0.5em}
            \setlength{\partopsep}{0ex}
            \setlength{\leftmargin}{0em}
	}%
	{%
		\end{enumerate}
	\end{flushleft}
\end{minipage} & \begin{minipage}{0.35\textwidth}
    \begin{flushright}
        \vspace*{\fill}

        \cellwidth{2cm}
        \gradetable[v][questions]
    \end{flushright}
\end{minipage}
\end{tabular}

		\bigskip
	}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Command for Signature Box

\newcommand{\namelabel}{\textbf{Name}:}
\newcommand{\stdnumlabel}{\textbf{Student Number}:}
\newcommand{\signaturelabel}{\textbf{Signature}:}
\newcommand{\signatureextra}{\normalsize I understand that cheating is a serious offence:}
\newcommand{\signatureunder}{(\emph{In Ink})}

\newcommand{\sig@size}{\large}
\newlength{\sig@vamt}
\newlength{\crowdmarksigspace}
\setlength{\crowdmarksigspace}{8.2cm}

\newcommand{\signatureBox}%
	{%
	    \ifthenelse{\boolean{LeftAlignedSignatureBox}}{%
	        \typeout{Signature Box: left aligned}
	    }{%
	        \typeout{Signature Box: centered}
	    }
	    \ifthenelse{\boolean{CompactSignatureBox}}{%
	        \typeout{Signature Box: compact}
	        \renewcommand{\sig@size}{\normalsize}
	        \setlength{\sig@vamt}{\medskipamount}
	    }{%
	        \typeout{Signature Box: spacious}
	        \setlength{\sig@vamt}{\bigskipamount}
	    }
		\begin{framed}
			\begin{sig@size}
                \ifthenelse{\boolean{LeftAlignedSignatureBox}}{%

                    \rule{0pt}{0.75\sig@vamt}

                    {\namelabel}\quad\hrulefill\quad

                    \rule{0pt}{\sig@vamt}

                    {\stdnumlabel}\quad\hrulefill\quad

                    \rule{0pt}{1.5\sig@vamt}

                    {\signatureextra}

                    \ifthenelse{\equal{\signatureextra}{}}{}{%
                        \rule{0pt}{1.5\sig@vamt}
                    }

                    {\signaturelabel}\quad\hrulefill

                    \rule{0pt}{0.75\sig@vamt}

                    {\signatureunder}

                }{%
                    \begin{center}
                        \setlength{\tymax}{0.35\textwidth}
						\addtolength{\sig@vamt}{\baselineskip}
                        \begin{tabulary}{0.95\textwidth}{Rp{0.6\textwidth}}
                            {\namelabel} & \hrulefill \\ \rule{0pt}{1.25\sig@vamt}
                            {\stdnumlabel} & \hrulefill \\ \rule{0pt}{0.25\sig@vamt}
                            \ifthenelse{\equal{\signatureextra}{}}{}{%
                                \rule{0pt}{0.75\sig@vamt} & {\signatureextra} \\ \rule{0pt}{1.25\sig@vamt} \
                            }
                            {\signaturelabel} & \hrulefill \ifthenelse{\equal{\signatureunder}{}}{}{\\ \rule{0pt}{1\sig@vamt}
                            &{\signatureunder} }
                        \end{tabulary}
                    \end{center}
                }
			\end{sig@size}
		\end{framed}
		\vspace{0.5\sig@vamt plus 0.5\sig@vamt minus 0.35\sig@vamt}
		}


\newcommand{\crowdmarkSignatureBox}%
	{%
	    \ifthenelse{\boolean{LeftAlignedSignatureBox}}{%
	        \typeout{Crowdmark Signature Box: left aligned}
	    }{%
	        \typeout{Crowdmark Signature Box: centered}
	    }
	    \typeout{Crowdmark Signature Box: spacious}
	    \setlength{\sig@vamt}{\bigskipamount}
		\begin{framed}
			\begin{sig@size}
                \ifthenelse{\boolean{LeftAlignedSignatureBox}}{%

                    \rule{0pt}{0.25\sig@vamt}

                    {\signatureextra}

                    \ifthenelse{\equal{\signatureextra}{}}{}{%
                        \rule{0pt}{1.5\sig@vamt}
                    }

                    {\signaturelabel}\quad\hrulefill
					\vspace*{0.25\sig@vamt}

                    {\signatureunder}
					\vspace*{1\sig@vamt}

                }{%
                    \begin{center}
						\vspace*{-1.5\sig@vamt}
                        \setlength{\tymax}{0.35\textwidth}
						\addtolength{\sig@vamt}{\baselineskip}
                        \begin{tabulary}{0.95\textwidth}{Rp{0.6\textwidth}}
                            \ifthenelse{\equal{\signatureextra}{}}{}{%
                                \rule{0pt}{0.75\sig@vamt} & {\signatureextra} \\ \rule{0pt}{1.25\sig@vamt} \
                            }
                            {\signaturelabel} & \hrulefill \ifthenelse{\equal{\signatureunder}{}}{}{\\ \rule{0pt}{0.25\sig@vamt}
                            &{\signatureunder} }
                        \end{tabulary}
                    \end{center}
                }
			\end{sig@size}
		\end{framed}
		\vspace*{\crowdmarksigspace}
		}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\sectionlistinstruction}{Please place a check mark beside your section number and instructor:}
\newenvironment{sectionlist}{%

    \vspace{0.5em plus 0.5em minus 0.5em}

    \noindent
    \textbf{\sectionlistinstruction}
	\begin{center}
        \begin{minipage}{0.85\textwidth}
            \noindent
            \begin{list}%
                {\Large$\Box$\ }%
                {%
                    \setlength{\topsep}{0.5em plus 0.5em minus 0.5em}%
                    \setlength{\partopsep}{0em}%
                    \setlength{\itemsep}{0.5em plus 0.5em minus 0.5em}%
                    \setlength{\parsep}{0em}%
                    \setlength{\itemindent}{-0.9em}%	% default 0.1em
                    \setlength{\leftmargin}{2.5em}%	% default 2.5em
                }%
	}{%
	    	\end{list}%
    		\end{minipage}%
		\end{center}%

		\medskip
	}%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% * Useful formulas (optional)
% * Table pages

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Include a ``blank'' page.

\newcommand{\blankpagetext}{Blank Page}
\newcommand{\blankPage}%
	{
		\newpage
		\begin{center}
		    \begin{Large}
		        [\blankpagetext]
		    \end{Large}
		\end{center}
		\newpage
	}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Include a ``blank'' page.

\newcommand{\workpagetext}{Use this page for scrap work.}
\newcommand{\workPage}%
	{
		\newpage
		\begin{center}
		    \begin{Large}
		        [\workpagetext]
		    \end{Large}
		\end{center}
		\newpage
	}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\skipPage}%
{
	\newpage\mbox{}\newpage
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A rule in the exam.

\newcommand{\examrule}%
	{%
		\fullwidth{\noindent\hrulefill} %
	}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A section in the exam, e.g.,
%	\examsection{Part A: Multiple Choice}

\newcommand{\examsection}[1]{{\vspace{\bigskipamount}\fullwidth{\normalfont\LARGE\bfseries\noindent #1}}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




\endinput
