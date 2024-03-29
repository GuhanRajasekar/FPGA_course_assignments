 \NeedsTeXFormat{LaTeX2e}
 \ProvidesClass{desethesis}[2010/08/15 DESE Theses and Dissertations]
%
% Revision History
%   15-08-2010 : CEDT Thesis class
%   15-08-2012 : DESE Thesis class
% Author: L Umanand

\RequirePackage{iisclogo}

% Variable declarations for text fields of preliminary pages

    \newcommand{\Title}[1]{\gdef\edField@Title{#1}}
    \newcommand{\Author}[1]{\gdef\edField@Author{#1}}
    \newcommand{\docname}[1]{\gdef\edField@DocName{#1}}
    \newcommand{\degree}[1]{\gdef\edField@Degree{#1}}
    \newcommand{\guided}[1]{\gdef\edField@guided{#1}}
    \newcommand{\Advisor}[1]{\gdef\edField@Advisor{#1}}
    \newcommand{\CoAdvisorA}[1]{\gdef\edField@CoAdvisorA{#1}}
    \newcommand{\CoAdvisorB}[1]{\gdef\edField@CoAdvisorB{#1}}
    \newcommand{\Month}[1]{\gdef\edField@Month{#1}}
    \newcommand{\Year}[1]{\gdef\edField@Year{#1}}
    \newcommand{\Dedication}[1]{\gdef\edField@Dedication{#1}}
    \newcommand{\Synopsis}[1]{\gdef\edField@Synopsis{#1}}
    \newcommand{\Keywords}[1]{\gdef\edField@Keywords{#1}}
    \newcommand{\Acknowledgments}[1]{\gdef\edField@Acknowledgments{#1}}

% Initialize variables to default values

    \Title{[Title: Title Must Be in Mixed Case. Long Titles Must be Broken up Such that
           the Subsequent Lines are Smaller than the Preceding ones
           to Obtain an Inverted Pyramid Format]}
    \Author{[Student Name]}
    \docname{A Thesis Submitted For The\\Degree Of}
    \degree{Doctor of Philosophy}
    \guided{Guided By}
    \Advisor{}
    \CoAdvisorA{}
    \CoAdvisorB{}
    \Month{[Month]}
    \Year{[Year]}
    \Dedication{[This work is dedicated to ......]}
    \Synopsis{[The synopsis is a summary of the thesis with emphasis on the main contributions
              of the research work. The synopsis must be around 500 words and is single spaced.]}
    \Keywords{[A comma-separated list of descriptive words for searching]}
    \Acknowledgments{[Acknowledgements should be simple, in good taste, and fit on one page]}

% Define the preliminary page layouts using the variables

    \newcommand{\edtitlepage}{
        \thispagestyle{empty}
        {\centering
        \providecommand\pdfbookmark[3][]{} \pdfbookmark[0]{Title Page}{bm:Title}
        \parbox[t]{6in}{
            \renewcommand{\baselinestretch}{1.5} \normalsize\Large\bfseries
            \centering\edField@Title\par
            \renewcommand{\baselinestretch}{1} \small\normalsize
            }\\[\baselineskip]\par
        \vfill
        \scshape\edField@DocName\\[\baselineskip]
        \parbox[t]{6in}{
            \renewcommand{\baselinestretch}{1.5} \normalsize\Large\bfseries\itshape
            \centering\edField@Degree\par
            \renewcommand{\baselinestretch}{1} \small\normalsize
            }\\[\baselineskip]\par
        \scshape In The\\Faculty Of Engineering
        \vfill
        By\\[\baselineskip]\normalsize
        \Large\edField@Author\\[\baselineskip]\normalsize
        \vfill
        \mbox{\edField@guided}\\[\baselineskip]
        \mbox{\edField@Advisor}\\
        \mbox{\edField@CoAdvisorA}\\
        \mbox{\edField@CoAdvisorB}\\
        \vfill
	  \iisclogo{1000}\\
        \parbox[t]{6in}{
            \renewcommand{\baselinestretch}{1.5} \small\normalsize\scshape\centering
                    Department of Electronic Systems Engineering\\
                    Indian Institute Of Science, Bangalore\\[\baselineskip]
                    \mbox{\edField@Month~\edField@Year} \\
            \renewcommand{\baselinestretch}{1} \small\normalsize
            }\\[\baselineskip]\par
        \vfill
        Copyright \copyright\ \edField@Year~IISc\\
        All Rights Reserved\par
        }
        \clearemptydoublepage
      }

    \newcommand{\dedicationpage}{
        \thispagestyle{empty}
        {\raggedleft
        \providecommand\pdfbookmark[3][]{} \pdfbookmark[0]{Dedication}{bm:Dedication}
        \normalsize\large\itshape This work is dedicated to\\[\baselineskip]\par
        \bfseries \edField@Dedication \ldots\\[\baselineskip]\par 
        } 
        \par \renewcommand{\baselinestretch}{1} \small\normalsize%
        \clearemptydoublepage
    }
    \newcommand{\synopsispage}{
        \thispagestyle{empty}
        {\centering
        \providecommand\pdfbookmark[3][]{} \pdfbookmark[0]{Synopsis}{bm:Synopsis}
        SYNOPSIS\\[\baselineskip]\par
        }
        \noindent Keywords:~\edField@Keywords\\[\baselineskip]
        \renewcommand{\baselinestretch}{1} \small\normalsize%
        \edField@Synopsis\par
        \renewcommand{\baselinestretch}{1} \small\normalsize%
        \clearemptydoublepage
    }

    \newcommand{\acknowledgmentspage}{
        \singlespace
        \thispagestyle{empty}
        {\centering
        \providecommand\pdfbookmark[3][]{} \pdfbookmark[0]{Acknowledgments}{bm:Acknowledge}
        ACKNOWLEDGMENTS\\[3\baselineskip]
        \par}\par
        \renewcommand{\baselinestretch}{1.3} \small\normalsize%
        \edField@Acknowledgments
        \par\renewcommand{\baselinestretch}{1} \small\normalsize%
        \clearemptydoublepage
        }

% Allow opt-out on synopsis page
    \DeclareOption{nosyn}{
      \renewcommand{\synopsispage}{}
    }

% Allow opt-out on dedication page
    \DeclareOption{noded}{
      \renewcommand{\dedicationpage}{}
    }

% Allow opt-out on acknowledgments
    \DeclareOption{noack}{
      \renewcommand{\acknowledgmentspage}{}
    }

% Define the macro for making preliminary pages
    \newcommand{\makepreliminarypages}{
        \changepage{0.5in}{}{}{}{}{}{-0.2in}{-0.3in}{}
        \edtitlepage
        \dedicationpage
        \synopsispage
        \acknowledgmentspage
        \renewcommand{\clearemptydoublepage}{\cle@remptydoublep@ge}
        \changepage{-0.5in}{}{}{}{}{}{0.2in}{0.3in}{}
    }


% Define the following class options to specify thesis type
%
%   phd     : Produces the PhD dissertation preliminary pages
%   mtech   : Produces the MTech thesis preliminary pages
%   me      : Produces the ME thesis preliminary pages


    \DeclareOption{mtech}{
      \degree{Master of Technology}
      \docname{A DISSERTATION SUBMITTED IN PARTIAL FULFILMENT\\FOR THE DEGREE OF}
    }

    \DeclareOption{me}{
      \degree{Master of Engineering}
      \docname{A DISSERTATION SUBMITTED IN PARTIAL FULFILMENT\\FOR THE DEGREE OF}
    }

    \DeclareOption{phd}{
      \renewcommand{\makepreliminarypages}{
        \changepage{0.5in}{}{}{}{}{}{-0.2in}{-0.3in}{}
        \edphdtitlepage
        \dedicationpage
        \synopsispage
        \acknowledgmentspage
        \renewcommand{\clearemptydoublepage}{\cle@remptydoublep@ge}
        \changepage{-0.5in}{}{}{}{}{}{0.2in}{0.3in}{}
      }
    }

   \newcommand{\edphdtitlepage}{
        \thispagestyle{empty}
        {\centering
        \providecommand\pdfbookmark[3][]{} \pdfbookmark[0]{Title Page}{bm:Title}
        \parbox[t]{6in}{
            \renewcommand{\baselinestretch}{1.5} \normalsize\Large\bfseries
            \centering\edField@Title\par
            \renewcommand{\baselinestretch}{1} \small\normalsize
            }\\[\baselineskip]\par
        \vfill
        \scshape\edField@DocName\\[\baselineskip]
        \parbox[t]{6in}{
            \renewcommand{\baselinestretch}{1.5} \normalsize\Large\bfseries\itshape
            \centering\edField@Degree\par
            \renewcommand{\baselinestretch}{1} \small\normalsize
            }\\[\baselineskip]\par
        \scshape In The\\Faculty Of Engineering
        \vfill
        By\\[\baselineskip]\normalsize
        \Large\edField@Author\\[\baselineskip]\normalsize
        \vfill
	  \iisclogo{1000}\\
        \vfill
        \parbox[t]{6in}{
            \renewcommand{\baselinestretch}{1.5} \small\normalsize\scshape\centering
                    Department of Electronic Systems Engineering\\
                    Indian Institute Of Science, Bangalore\\[\baselineskip]
                    \mbox{\edField@Month~\edField@Year} \\
            \renewcommand{\baselinestretch}{1} \small\normalsize
            }\\[\baselineskip]\par
        \vfill
        Copyright \copyright\ \edField@Year~IISc\\
        All Rights Reserved\par
        }
        \clearemptydoublepage
      }



% A couple of useful macros for students

    % The \singlespace macro switches to single spaced lines
    \newcommand{\singlespace}{\par\renewcommand{\baselinestretch}{1}\small\normalsize\par}

    % The \doublespace macro switches to double spaced lines
    \newcommand{\doublespace}{\par\renewcommand{\baselinestretch}{1.3}\small\normalsize\par}


% A command to handle single sided preliminary pages in a double sided environment

    % Define the '\clearemptydoublepage' command to clear pages but not number any blank pages inserted.
    \let\cle@rdoublep@ge\cleardoublepage
    \newcommand{\cle@remptydoublep@ge}{
      \clearpage
      \if@twoside
      \ifodd\c@page\else
      \fi\fi
      {\pagestyle{empty}\cle@rdoublep@ge}}
    \newcommand{\clearemptydoublepage}{\cle@remptydoublep@ge}

\DeclareOption{etd}{
    \renewcommand{\clearemptydoublepage}{\clearpage}
    }


% Load the class and needed packages

    \DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
    \ProcessOptions
    \relax
    \LoadClass[a4paper,12pt]{book}

    \RequirePackage{changepage}
    \RequirePackage[a4paper,left=1.25in,right=0.75in]{geometry}
    \RequirePackage[pdftex]{graphicx}
    \RequirePackage{amsmath}
    \RequirePackage{amssymb}
    \RequirePackage{amsthm}
    \RequirePackage{multirow}
    \RequirePackage[normalem]{ulem}		
    \RequirePackage[section]{placeins}
    \RequirePackage{fancyhdr}
    \RequirePackage{lastpage}
    \RequirePackage{makeidx}
    \makeindex

% Set the margins to DESE specifications

%    \setlength{\marginparwidth}{0pt}
%    \setlength{\marginparsep}{0pt}
%    \setlength{\oddsidemargin}{0in}
%    \setlength{\evensidemargin}{0in}
%    \setlength{\textwidth}{6.2in}
%    \setlength{\topmargin}{0in}
%    \setlength{\footskip}{1in}
    \setlength{\textheight}{9.2in}
    \setlength\headheight{20pt}
    \setlength{\headsep}{10pt}
    \setlength\parindent{0in}
    \setlength\parskip{6pt}
    \raggedbottom

% Redefine the Table of Contents to deal with some blank page
% and bookmarking issues relating to ETD submission
    \let\TEMPtableofcontents\tableofcontents
    \renewcommand{\tableofcontents}{
      \clearemptydoublepage
      \providecommand\phantomsection{} \phantomsection
      \addcontentsline{toc}{chapter}{Table of Contents}
      \TEMPtableofcontents
    }

% Redefine the List of Figures to deal with some blank page
% and bookmarking issues
    \let\TEMPlistoffigures\listoffigures
    \renewcommand{\listoffigures}{
      \providecommand\phantomsection{} \phantomsection
      \addcontentsline{toc}{chapter}{List of Figures}
      \TEMPlistoffigures
    }

% Redefine the Bibliography to deal with a bookmarking issues
    \let\TEMPbibliography\bibliography
    \renewcommand{\bibliography}{
      \providecommand\phantomsection{} \phantomsection
      \addcontentsline{toc}{chapter}{Bibliography}
      \TEMPbibliography
    }

%Headers and footers
\pagestyle{fancy}
\renewcommand{\chaptermark}[1]{%
\markboth{\chaptername\ \thechapter.\ #1}{}}
\renewcommand{\sectionmark}[1]{\markright{\thesection.\ #1}}
\renewcommand{\headrulewidth}{0.5pt}
%\renewcommand{\footrulewidth}{0.5pt} 
\fancyhead[RE,LO]{\thepage}
\fancyfoot{}
%\lhead{DESE report} 
%\chead{} 
%\rhead{report title} 
%\lfoot{Author name} 
%\cfoot{\thepage /\pageref{LastPage}} 
%\rfoot{\thepage /\pageref{LastPage}}
