% Class: purana
% Version: 0.01-2020/12/14
% License: LPPL 1.3c
% GitHub Repo: https://github.com/elvendrim/shivamahapurana/
%
% This Work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, in its
% version 1.3c. This version of this license is in
% http://www.latex-project.org/lppl/lppl-1-3c.txt
% and the latest version of this license is in
% http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of
% LaTeX version 2005/12/01 or later.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{purana}[2020/12/14 v0.1 Standard book class
                       for typsetting purāṇas in IAST/Devanāgarī]

% Pre-defined options
% Font size
\newcommand\purana@fontsize{12pt} % Set default fontsize to 12pt
\DeclareOption{10pt}{\renewcommand\purana@fontsize{10pt}}%
\DeclareOption{11pt}{\renewcommand\purana@fontsize{11pt}}%
\DeclareOption{12pt}{\renewcommand\purana@fontsize{12pt}}%
\PassOptionsToClass{\purana@fontsize}{book}%

% Page size
\newcommand\purana@papersize{a4paper} % Set default as a4paper
\DeclareOption{a4paper}{\renewcommand\purana@papersize{a4paper}}%
\DeclareOption{a5paper}{\renewcommand\purana@papersize{a5paper}}%
\PassOptionsToClass{\purana@papersize}{book}%

% Column layout
\newif\if@oneside\@onesidefalse
\DeclareOption{oneside}{\PassOptionsToClass{\CurrentOption}{book}\@onesidetrue}%
\DeclareOption{twoside}{\PassOptionsToClass{\CurrentOption}{book}}%

% Generates warning for unknown options
\DeclareOption*{
\ClassWarning{purana}{Unknown or non-standard option '\CurrentOption'.
I'll see if I can load it from the book class. If you get a warning
unused global option(s): `\CurrentOption` then the option is not
supported!}
\PassOptionsToClass{\CurrentOption}{book}%
}

% Process options and load class
\ProcessOptions\relax%
\LoadClass{book}%

% Packages
\RequirePackage{ifthen}   % Conditional statements
\RequirePackage{iftex}    % Check for LaTeX, XeLaTeX, etc.
\RequirePackage{calc}     % Calculate vertical spacing
\RequirePackage{keyval}   % Key/Value statements
\RequirePackage{etoolbox} % A toolbox of programming facilities
\RequirePackage{varwidth} % A variable-width minipage
\RequirePackage{xspace}   % Adds a space at the end of a textmacro
\RequirePackage{textcase} % Case conversion ignoring mathematics, etc.
\RequirePackage{setspace} % Set space between lines
\RequirePackage{enumitem} % Customizing lists
\RequirePackage{xfrac}    % Nice fractions
\RequirePackage{hologo}   % Better TeX/LaTex/XeLaTeX logos

% Set the geometry for the pages
\RequirePackage{geometry}
  \geometry{%
    paperwidth=210mm,
    paperheight=297mm
  }

% Paragraph identation
\RequirePackage[parfill]{parskip}
\setlength{\parindent}{0pt}
\setlength{\parskip}{6pt plus 2pt minus 4pt}
\setlength{\emergencystretch}{3em}
\frenchspacing

% Misc layout settings
\lefthyphenmin=3
\righthyphenmin=3 % Disable single lines at the start of a paragraph
\clubpenalty=10000 % Disable single lines at the end of a paragraph
\widowpenalty=10000

% Clear header style on the last empty odd pages
\renewcommand{\cleardoublepage}{\clearpage\if@twoside \ifodd\c@page\else%
	\hbox{}%
	\thispagestyle{empty} % Empty header styles
	\newpage%
  \if@twocolumn\hbox{}\newpage\fi\fi\fi}

% Hide Contents appearing from ToC, but add it to bookmarks
\let\temptableofcontents\tableofcontents
\renewcommand{\tableofcontents}{
  \cleardoublepage
  \pdfbookmark[0]{\contentsname}{Contents}
  \temptableofcontents
}

% Removes pagenumber appearing from TOC
\addtocontents{toc}{\protect\thispagestyle{empty}}
\addtocontents{toc}{\protect\vspace*{3ex}} % Put vertical space in the ToC after the ‘Contents’ header
\RequirePackage{tocbasic}
\addtotoclist[book.cls]{toc}
\renewcommand*{\tableofcontents}{\listoftoc[{\contentsname}]{toc}}% ToC under control of tocbasic
\AfterTOCHead[toc]{\thispagestyle{empty}\pagestyle{empty}}
\AfterStartingTOC[toc]{\clearpage}

% Colors
\RequirePackage[usenames, dvipsnames]{xcolor}
\RequirePackage{latexcolors}
% \definecolor{darkpowderblue}{rgb}{0.0, 0.2, 0.6}
% \definecolor{cadmiumred}{rgb}{0.89, 0.0, 0.13}

% Use fontspec and OpenType fonts with XeLaTeX
\RequirePackage{fontspec}
  \defaultfontfeatures{Mapping=tex-text}
  \setmainfont{adobedevanagari}[%
    Extension   = .otf,
    UprightFont = *-regular,
    ItalicFont  = *-italic,
    BoldFont    = *-bold,
    BoldItalicFont = *-bolditalic
  ]

% Multilingual support
\RequirePackage{polyglossia}
  \setdefaultlanguage{english}
  \setotherlanguage{sanskrit}

% Sanskrit text in Roman tranliteration
\newfontfamily\sanskritfont{Adobe Devanagari}[Scale=MatchLowercase]
\newcommand{\tl}[1]{\sanskritfont\emph{#1}}
% Sanskrit text in Devanāgarī
\newfontfamily\devanagarifont{Adobe Devanagari}[Script=Devanagari,Scale=MatchUppercase]
\newcommand{\dn}[1]{{\devanagarifont#1}}

\newenvironment{shloka}[1]
  {\bigskip\center#1\varwidth{\linewidth}}
  {\endvarwidth\endcenter\bigskip}

% Clear header style for all pages
\RequirePackage{fancyhdr}
  \pagestyle{fancy}
    \fancyhf{}%
    \fancyhead{}%
    \renewcommand{\headrulewidth}{\iffloatpage{0pt}{0pt}}
    \fancyfoot[RO,LE]{\thepage}

% Fine-tune hyperreferences (hyperref should be called last)
\RequirePackage{hyperref}
\RequirePackage{url}
  \hypersetup{%
    breaklinks=true,%
    linktocpage,%
    colorlinks=true,%
    linkcolor=darkpowderblue,%
    urlcolor=darkpowderblue,%
    citecolor=darkpowderblue,%
    anchorcolor=darkpowderblue,%
    pdfdisplaydoctitle=true%
  }
  \urlstyle{same}

% Subtitle (optional)
\newcommand{\@subtitle}{}
\newcommand{\subtitle}[1]{\renewcommand{\@subtitle}{#1}}

% Subjectline (This subject will appear in the PDF meta-information
% called `pdfsubject`.)
\newcommand{\@subject}{}
\newcommand{\subject}[1]{\renewcommand{\@subject}{#1}}

% Keywords (These keywords will appear in the PDF meta-information
% called `pdfkeywords`.)
\newcommand{\@keywords}{}
\newcommand{\keywords}[1]{\renewcommand{\@keywords}{#1}}

% PDF meta-information
\AtBeginDocument{
  \hypersetup{%
    pdftitle={\@title},%
    pdfauthor={\@author},%
    pdfsubject={\@subject},%
    pdfkeywords={\@keywords},%
    pdfcreator={XeLaTeX},%
    pdfproducer={LaTeX with hyperref and Shivapurana}%
  }
}

\long\def\coverpage{%
  \clearpage
  \thispagestyle{empty}
  \begingroup
    \parindent0pt
    \begin{minipage}{\linewidth}
      \centering
      \LARGE\bfseries
      {\addfontfeature{LetterSpace=8}\MakeTextUppercase{\@title}}
      \par\vspace*{15mm}
      {\addfontfeature{LetterSpace=8}\@subtitle}
      \par\vspace*{15mm}
    \end{minipage}
    \par\vspace*{15mm}
    \bigskip
  \endgroup
}

\long\def\copyrightpage{%
  \clearpage
  \thispagestyle{empty}
  \begingroup
    \footnotesize
    \begin{minipage}[t][.98\textheight][t]{\linewidth}
      {\bfseries \@title}\par
      by {\itshape \@author}
      \vfill
      ``\@title{}'' by \@author{} provides immediate open access to its content on the
      principle that making research freely available to the public supports
      a greater global exchange of knowledge.
      \par
      \medskip
      This work may be distributed and/or modified under the conditions of the
      \href{http://www.creativecommons.org/licenses/by-sa/4.0/}{Creative Commons Attribution-Share Alike 4.0} License.
      \par
      \medskip
      The electronic version was generated from sources marked up in
      \href{http://www.latex-project.org}{\hologo{LaTeX}}. PDF document was typeset
      using \href{http://tug.org/xetex/}{\hologo{XeLaTeX}} from
      \href{http://tug.org/texlive/}{\hologo{TeX}Live}.
      The base font used for Latin script was
      \href{https://fonts.adobe.com/fonts/adobe-devanagari}{Adobe Devanagari},
      designed by Fiona Ross, Robert Slimbach, and Tim Holloway for  Adobe Originals.
    \end{minipage}
  \endgroup
}

\makeatletter
\@addtoreset{chapter}{part}
\makeatother

\makeatletter
\renewcommand*\part{%
  \cleardoublepage
  \thispagestyle{empty}%
  \if@twocolumn
    \onecolumn
    \@tempswatrue
  \else
    \@tempswafalse
  \fi
  \null\vfil
  \secdef\@part\@spart}
\makeatother

% Local generic author-facing macros:
\newcommand{\st}{\textsuperscript{\textup{st}}\xspace}
\newcommand{\nd}{\textsuperscript{\textup{nd}}\xspace}
\newcommand{\rd}{\textsuperscript{\textup{rd}}\xspace}
\renewcommand{\th}{\textsuperscript{\textup{th}}\xspace}

\def\bce{\MakeTextUppercase{bce}\xspace}
\def\ce{\MakeTextUppercase{ce}\xspace}
\let\BC\bce \let\BCE\bce \let\AD\ce \let\CE\ce

\def\eg{\textit{e.g.,}\xspace}
\def\ie{\textit{i.e.,}\xspace}
\def\Eg{\textit{E.g.,}\xspace}
\def\Ie{\textit{I.e.,}\xspace}
\def\viz{\textit{viz.}\@\xspace}
\def\Viz{\textit{Viz.}\@\xspace}
\def\etal{\textit{et~al.}\@\xspace}
\def\etc{\textit{etc.}\@\xspace}
