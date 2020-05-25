%% scrbluebook - a specialization for scrbook
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tex/scrbluebook}[2020/05/25 scrbluebook]
\LoadClass[
	12pt,
	cleardoublepage=plain,  % page numbers on blank pages
	twoside,
	bibliography=totoc,
	listof=totoc,
	titlepage
]{scrbook}

%% Options for this class

% ...

%% Package declarations
\include{tex/assets/packages}

%% Color-Scheme
\include{tex/assets/color-scheme}

%% New commands
\include{tex/assets/commands}