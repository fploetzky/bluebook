%% scrbluebook - a specialization for scrbook
%% Based on the KOMA classes by Frank Neukam, Markus Kohm and Axel Kielhorn
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tex/bluebook}[2020/05/25 scrbluebook]
\LoadClass[
	12pt,
	cleardoublepage=plain,  % page numbers on blank pages
	twoside,
	bibliography=totoc,
	listof=totoc,
	titlepage
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

%% New commands
\newcommand{\providedByMe}{ProvidedByMe}

%% Hyperref
% PDF linkings and metadata
\usepackage[
	pdfpagelayout=TwoPageRight, % Activate 2-page layout for PDFs (if the PDF viewer supports this view)
	% hidelinks,
	colorlinks=true,
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

%% Header and Footer
% compare the KOMA manual p. 263 and following
\usepackage[
	footsepline,       % separator for the footer
	headsepline,       % separator for the header
	plainfootsepline,  % like footsepline but for the "plain" pages (e.g. chapter pages)
	autooneside=false, % didn't quite got the point ... needed in combination with automark
	automark           % altered chapter headings
]{scrlayer-scrpage}

\pagestyle{scrheadings}

% Set the font family and size for header and footer
\setkomafont{pageheadfoot}{\small\sffamily\color{chaptercolor}}
\setkomafont{pagehead}{\itshape\sffamily\color{chaptercolor}} % \bfseries

% We have to change header and footer with respect to even and odd page numbers.
% Additionally, the design depends on the print style (oneside vs twoside).
% https://tex.stackexchange.com/questions/360785/how-do-i-check-if-a-document-is-oneside-or-twoside
\makeatletter
\if@twoside
	% <-- even  odd -->
	% for the twoside scenario we need to display a page number on the left side of the footer
	% if the page number is even - otherwise it should be displayed on the right side of the footer
	% \rofoot[\textbf{\thepage}]{\textbf{\thepage}}
	% \lefoot[\textbf{\thepage}]{\textbf{\thepage}}
	\rofoot[\thepage]{\color{chaptercolor}\thepage}
	\lefoot[\thepage]{\color{chaptercolor}\thepage}
	% delete default number in the footer's center
	\cefoot[]{}
	\cofoot[]{}
\else
	% for oneside the page number should always be on the right side
	% \refoot[\textbf{\thepage}]{\textbf{\thepage}}
	% \rofoot[\textbf{\thepage}]{\textbf{\thepage}}
	\refoot[\thepage]{\color{chaptercolor}\thepage}
	\rofoot[\thepage]{\color{chaptercolor}\thepage}
	
	% again delete the default page number
	\cefoot[]{}
	\cofoot[]{}
\fi  
\makeatother

%% Page setup
% page borders
\usepackage{geometry} 
\geometry{a4paper}
\geometry{left=30mm,right=30mm,top=30mm,bottom=25mm,head=14.5pt}

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
\renewcommand*{\marginfont}{\itshape\color{chaptercolor}\footnotesize\sffamily}

% Small TikZ graphics for various purposes
\newcommand{\triangleRightSide}{
	\scalebox{.1}{
		\begin{tikzpicture}
		\draw[fill=black] (2,0) -- (2,2) -- (0,1) -- (2,0);
		\end{tikzpicture}
	}
}

\newcommand{\triangleLeftSide}{
	\scalebox{.1}{
		\begin{tikzpicture}
		\draw[fill=black] (0,0) -- (0,2) -- (2,1) -- (0,0);
		\end{tikzpicture}
	} 
}

\newcommand{\triangleRegular}{
	\scalebox{0.08}{
		\begin{tikzpicture}
		\draw[fill=black] (0,0) 
		-- (4,0) 
		-- (2,4) 
		-- cycle;
		\end{tikzpicture}
	}
}

\newcommand{\mySquare}{
	\scalebox{0.05}{
		\begin{tikzpicture}
		\draw[fill=chaptercolor, color=chaptercolor] (0,0) 
		-- (4,0) 
		-- (4,4) 
		-- (0,4)
		-- cycle;
		\end{tikzpicture}
	}
}

\newcommand{\myBlackSquare}{
	\scalebox{0.05}{
		\begin{tikzpicture}
		\draw[fill=black, color=black] (0,0) 
		-- (4,0) 
		-- (4,4) 
		-- (0,4)
		-- cycle;
		\end{tikzpicture}
	}
}

\newcommand{\myCircle}{
	% \scalebox{0.08}{
	\begin{tikzpicture}
	\draw[fill=black] (0,0) circle (.7ex);
	\end{tikzpicture}
	% }
}

\newcommand{\myDiamond}{
	\scalebox{0.08}{
		\begin{tikzpicture}
		\draw[fill=black] (2,0) -- (4,2) -- (2,4) -- (0,2) -- cycle;
		\end{tikzpicture}
	}
}

% map \Ifthispageodd to \ifthispageodd for backward compatibility reasons
\ifdefined\Ifthispageodd
	\message{Ifthispageodd is defined}%
\else
	\newcommand{\Ifthispageodd}{\ifthispageodd}
\fi

% small spacing between a paragraph and the preceding paragraph
\setlength{\parskip}{0.15em}

% disable the ident for the paragraphs
\setlength{\parindent}{0pt}

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

%% Side annotations in two variants
%% Hints for notation elements or misc stuff. Displayed with a side triangle
\makeatletter
\if@twoside
\newcommand{\sidenoteHint}[1]{
	\Ifthispageodd{
		% odd page: <- text
		\marginnote{
			\triangleRightSide\\
			#1
		}
	}{
		\marginnote{
			\triangleLeftSide\\
			#1
		}
	}
}
\else
\newcommand{\sidenoteHint}[1]{
	\marginnote[right]{
		\triangleRightSide\\
		#1
	}
}
\fi  
\makeatother

% Side annotation if a new concept is introduced or a new part in running text begins
% annotated with a square
\makeatletter
\if@twoside
\newcommand{\sidenotePart}[1]{
	\Ifthispageodd{
		% odd page: <- text
		\marginnote{
			\mySquare\\
			#1
		}
	}{
		% even page: text ->
		\marginnote{
			\mySquare\\
			#1
		}
	}
}
\else
% one page setup => always display side notes on the right side
\newcommand{\sidenotePart}[1]{
	\marginnote[right]{
		\mySquare\\
		#1
	}
}
\fi  
\makeatother

%% Enlarge the box holding the page numbers in the lists of everything. Needed if the
%% appendix grows and the roman numbers break the default box size
%% https://tex.stackexchange.com/questions/502159/scrbook-roman-page-numbers-in-toc-are-wider-than-textwidth
%\makeatletter
%\renewcommand\@pnumwidth{3em}
%\makeatother
