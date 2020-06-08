%% scrbluebook - a specialization for scrbook
%% Based on the KOMA classes by Frank Neukam, Markus Kohm and Axel Kielhorn
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tex/bluebook}[2020/05/25 bluebook]
\LoadClass[
	12pt,
	twoside,
	bibliography=totoc,
	listof=totoc,
	titlepage,
	headings=twolinechapter
]{scrbook}

%% Options for this class
% §1 actual options
\DeclareOption{german}{\let\@german\@empty}
\ProcessOptions

% §2 commands to check the options
\newcommand{\ifgerman}[2]{\ifx\@german\@undefined #2 \else #1 \fi}

%% Package declarations
% font, graphics, colors and language support
\RequirePackage{graphicx}
\ifgerman{
	\RequirePackage[ngerman]{babel}
}{
	\RequirePackage[english]{babel}
}
\RequirePackage{lmodern}
\RequirePackage[babel=true]{csquotes}
\RequirePackage{xcolor}

% Graphic handling
\RequirePackage{graphicx}
\graphicspath{{graphics/}}

% allows \includegraphics handle Tikz graphics in *.tikz files
\RequirePackage{tikzscale}

% continue footnote count even if a new chapter is arrived
\RequirePackage{chngcntr}
\counterwithout{footnote}{chapter}

% TikZ and pgfplots for various purposes
\RequirePackage{tikz}
\usetikzlibrary{fadings}
\usetikzlibrary{plotmarks}
\usetikzlibrary{calc}

\RequirePackage{pgfplots}
\pgfplotsset{compat=newest} % use the newest version for cross-compatibility
\usepgfplotslibrary{colorbrewer}

% normalize tikz font size
\tikzset{
	font={\fontsize{10pt}{12}\selectfont}}

%% Color-Scheme
% Tol Color Palette for color-blind friendly accents:
% https://davidmathlogic.com/colorblind/#%23332288-%23117733-%2344AA99-%2388CCEE-%23DDCC77-%23CC6677-%23AA4499-%23882255
\definecolor{cb-purple}{HTML}{332288}
\definecolor{cb-green}{HTML}{117733}
\definecolor{cb-lime}{HTML}{44AA99}
\definecolor{cb-cyan}{HTML}{88CCEE}
\definecolor{cb-yellow}{HTML}{DDCC77}
\definecolor{cb-red}{HTML}{CC6677}
\definecolor{cb-magenta}{HTML}{AA4499}
\definecolor{cb-wine}{HTML}{882255}

% Color for the chapter titles and sidenotes (dark blue)
\definecolor{chaptercolor}{HTML}{0047AB}

%% Hyperref
% PDF linkings and metadata
\usepackage[
	pdfpagelayout=TwoPageRight, % Activate 2-page layout for PDFs (if the PDF viewer supports this view)
	% hidelinks,
	colorlinks=true,
	pdfpagelabels,
	plainpages=false,
	linkcolor=cb-purple,
	anchorcolor=black,
	citecolor=cb-green,
	filecolor=cb-cyan,
	menucolor=cb-red,
	urlcolor=cb-cyan
]{hyperref}

\usepackage{url}
\urlstyle{tt}

% improved referencing in the document. Use \cref{<bib key>}
\usepackage[
	capitalise,
	noabbrev
]{cleveref}

% alter the appearance of sub-references in subfigure environments to the thesis standard
\newcommand{\styleSubref}[1]{{\sffamily\bfseries\color{chaptercolor}(\subref{#1})}}

% end notes
\RequirePackage{enotez}
\renewcommand*\enmark[1]{\textsuperscript{\textbf{#1.}}}

\setenotez{
	backref,
	totoc=chapter,
	split=chapter,
	split-title={\chaptername\ <ref>}
}

% footnotes should become endnotes
\let\footnote=\endnote

%% Header and Footer
% compare the KOMA manual p. 263 and following
\usepackage[
%	headwidth=textwithmarginpar,
%	footsepline,       % separator for the footer
	headsepline,       % separator for the header
	plainfootsepline,  % like footsepline but for the "plain" pages (e.g. chapter pages)
	autooneside=false, % didn't quite got the point ... needed in combination with automark
	automark           % altered chapter headings
]{scrlayer-scrpage}

\pagestyle{scrheadings}

% Set the font family and size for header and footer
\setkomafont{pageheadfoot}{\small\sffamily\color{chaptercolor}}
\setkomafont{pagehead}{\itshape\sffamily\color{chaptercolor}} 
\addtokomafont{pagenumber}{\color{chaptercolor}}

% We have to change header and footer with respect to even and odd page numbers.
% Additionally, the design depends on the print style (oneside vs twoside).
% https://tex.stackexchange.com/questions/360785/how-do-i-check-if-a-document-is-oneside-or-twoside
\makeatletter
\if@twoside
	\cehead{\headmark}
	\lehead[\pagemark]{\pagemark}
	\rohead[\pagemark]{\pagemark}
	\cohead{\headmark}
	
	\lofoot{}
	\lefoot{}
	\cofoot{}
	\cefoot{}		
	\rofoot{}
	\refoot{}	
\else
	\rehead{\headmark}
	\rehead[\pagemark]{\pagemark}
	\rohead[\pagemark]{\pagemark}
	\rohead{\headmark}
\fi  
\makeatother

%\RequirePackage{emptypage}

%% Page setup
% page borders
\usepackage{geometry} 
\geometry{a4paper}
\geometry{
	textwidth=400pt,
	top=40mm,
	bottom=35mm,
	head=15pt
}

% suppress widows and orphans
\clubpenalty = 10000
\widowpenalty = 10000
\displaywidowpenalty = 10000

% ---------  microtypography enabled
% activate={true,nocompatibility} - activate protrusion and expansion
% final - enable microtype; use "draft" to disable
% tracking=true, kerning=true, spacing=true - activate these techniques
% factor=1100 - add 10% to the protrusion amount (default is 1000)
% stretch=10, shrink=10 - reduce stretchability/shrinkability (default is 20/20)
% Provided by Siarhei Khirevich (http://www.khirevich.com/latex/microtype/)
\usepackage[
	activate={true,nocompatibility},
	final,
	tracking=true,
	kerning=true,
	spacing=true,
	factor=1100,
	stretch=10,
	shrink=10
]{microtype}
\microtypecontext{spacing=nonfrench}

% for the landscape command (also in PDFs)
%\usepackage{lscape} 
\usepackage{pdflscape}

% side notes
\usepackage{marginnote}

% change default appearance of the side notes
\renewcommand*{\marginfont}{\color{chaptercolor}\footnotesize\sffamily}


% map \Ifthispageodd to \ifthispageodd for backward compatibility reasons
\ifdefined\Ifthispageodd
	\message{Ifthispageodd is defined}%
\else
	\newcommand{\Ifthispageodd}{\ifthispageodd}
\fi

% small spacing between a paragraph and the preceding paragraph
\setlength{\parskip}{0.15em}

% disable the ident for the paragraphs
%\setlength{\parindent}{0pt}

% Change the caption titles
\usepackage{caption}
\captionsetup{margin=10pt}
\setkomafont{captionlabel}{\bfseries\sffamily\small\color{chaptercolor}}
\setkomafont{caption}{\small}
\setcapindent{0pt}

% for subfigures
\usepackage{subcaption}

% Change all captions in the thesis to the chaptercolor
%https://tex.stackexchange.com/questions/288737/customizing-chapter-and-section-style-scrbook
\addtokomafont{disposition}{\selectfont\color{chaptercolor}}
\renewcommand*{\chapterformat}{
	\raggedleft\thechapter\enskip
}

% text circles
\newcommand*\circled[1]{\tikz[baseline=(char.base)]{
		\node[shape=circle,draw,inner sep=1pt] (char) {#1};}}

%% Enlarge the box holding the page numbers in the lists of everything. Needed if the
%% appendix grows and the roman numbers break the default box size
%% https://tex.stackexchange.com/questions/502159/scrbook-roman-page-numbers-in-toc-are-wider-than-textwidth
%\makeatletter
%\renewcommand\@pnumwidth{3em}
%\makeatother

% Build title page
\RequirePackage{etoolbox}
\RequirePackage{pdfpages}
\RequirePackage{anyfontsize}

\makeatletter
\renewcommand{\maketitle}{%
	 \hypersetup{pageanchor=false}
   \thispagestyle{empty}
   % Cover
   \includepdf[pages=-,pagecommand={\begin{tikzpicture}[remember picture, overlay]
      \node at (2.5, 1) {\fontsize{40}{40}\sffamily\color{chaptercolor}\@title};
      \node at (1.5, -2) {\fontsize{30}{30}\sffamily\color{black}\@author};
	\end{tikzpicture}}]{tex/cover/cover}
	% dirty fix - there should be a better way
	\newpage\thispagestyle{empty}%

  % Title page
 
 
  \begin{titlepage}%
  	\centering
  	\vspace*{3cm}
  	{\centering\sffamily\Huge\color{chaptercolor}%
	\@title}
	\vspace*{3cm}%
	
	{\sffamily\Large
			by}
		
	\vspace*{1cm}%
	
	{\sffamily\LARGE\color{chaptercolor}%
				\@author}
			
	\vspace{10cm}
	
	{\sffamily\Large\color{black}%
				\textcopyright{} \@date}
  \end{titlepage}%
 
  \newpage\thispagestyle{empty}%
%  \hypersetup{pageanchor=true}
}
\makeatother

% Index
\RequirePackage{imakeidx}
\indexsetup{othercode=\small, firstpagestyle=empty}
\makeindex[program=makeindex,columns=2,intoc=true,options={-s index_style.ist}]

\newcommand{\positiontextbox}[4][]{%
	\begin{tikzpicture}[remember picture,overlay]%
	%    \draw[step=0.5,gray!80!white] (current page.north west) grid (current page.south east); % For controlling
	\node[inner sep=10pt, right] at ($(current page.north west) + (#2,-#3)$) {\large\sffamily\color{white}#4};%
	\end{tikzpicture}%
}

\makeatletter
% prevent page breaks before subitems in the Index
% https://tex.stackexchange.com/questions/130169/how-can-i-prevent-a-column-break-before-the-first-sub-entry-in-the-index
\renewcommand\subitem{\@idxitem\nobreak\hspace*{20\p@}}
\makeatother

\makeatletter
\newcommand{\closeBook}[1]{%
\newpage\thispagestyle{empty}
\positiontextbox{1.0cm}{2.5}{
	{\Huge\color{chaptercolor}\sffamily\@title}
}
\positiontextbox{1.0cm}{4cm}{
	{\Large\color{black}\sffamily\@author}\par
}

\vspace*{1.5cm}
\begin{tikzpicture}[remember picture,overlay]
	\draw[chaptercolor,line width=3pt] (-4,0) -- (18,0);
\end{tikzpicture}%

\vspace*{2.5cm}

\centering
\begin{minipage}[c]{0.85\linewidth}
	\sffamily\large#1
\end{minipage}

\begin{tikzpicture}[remember picture,overlay]
	\fill [remember picture,overlay,chaptercolor] (current page.south west) -- (current page.south east) --++(0,4cm) -| (current page.south west) -- cycle;
\end{tikzpicture}%
\positiontextbox{18cm}{28cm}{\sffamily\@date}
}
\makeatother

% Remove the page number from "part" pages
% https://latex.org/forum/viewtopic.php?t=4293
\makeatletter
\renewcommand\part{%
	\if@openright
	\cleardoublepage
	\else
	\clearpage
	\fi
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

% The table of contents
% https://tex.stackexchange.com/questions/416523/remove-page-number-for-part-and-define-space-before-page-number-with-tocbasic
\newcommand\gobble[1]{}
%\newcommand\tocpageseparator{\footnotesize\,\mbox{---}\,}
\newcommand\tocpagenumberbox[1]{\mbox{#1}}

%% Chapter style
% https://tex.stackexchange.com/questions/298491/replace-titlesec-chapter-style-with-koma
\RedeclareSectionCommand[
	beforeskip=\dimexpr3.3\baselineskip+1\parskip\relax,
	innerskip=0pt,% <- space between chapter number and chapter title
	afterskip=10\baselineskip,
	pagestyle=empty
%	afterskip=1.725\baselineskip plus .115\baselineskip minus .192\baselineskip	
]{chapter}

\renewcommand\raggedchapter{\centering}
\renewcommand\raggedsection{\centering}
\renewcommand\chapterformat{{\fontsize{80pt}{80pt}\selectfont\textcolor{chaptercolor!25}{\thechapter}}}

\RedeclareSectionCommands[
%	beforeskip=1\baselineskip,%0pt plus 1ex minus .2ex,
%	afterskip=3\baselineskip,%1sp plus .2ex,
	toclinefill=\hfill
]{section,subsection}
\renewcommand*{\sectionformat}{\thesection\hspace*{1em}}
\renewcommand*{\subsectionformat}{\thesubsection\hspace*{1em}}

% maximium subsection for the TOC
\setcounter{secnumdepth}{2}

