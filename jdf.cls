\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{jdf}[2019/08/10 v2.1.0 Joyner Document Format]

\newcommand{\papersize}{letterpaper} % Default value
\DeclareOption{a4paper}{\renewcommand{\papersize}{a4paper}}
\DeclareOption{letterpaper}{\renewcommand{\papersize}{letterpaper}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}} % Pass through any options to the base class
\ProcessOptions\relax % Process given options
\LoadClass{article}

\RequirePackage{etoolbox} % Required for conditional logic


%%
% Page layout
\ifstrequal{\papersize}{a4paper}{ % A4 paper page geometry settings
	\RequirePackage[
		a4paper,
		top=26.25mm,
		bottom=42.472mm, 
		left=34.361mm, 
		right=34.361mm,
		footskip=16.222mm, % Space from the bottom margin to the baseline of the footer
		%showframe, % Uncomment to show how the type block is set on the page
	]{geometry}
}{ % Default (letterpaper) page geometry settings
	\RequirePackage[
		\papersize,
		top=1in,
		bottom=1.5in, 
		left=1.5in, 
		right=1.5in,
		footskip=0.5in, % Space from the bottom margin to the baseline of the footer
		%showframe, % Uncomment to show how the type block is set on the page
	]{geometry}
}

\RequirePackage{graphicx} % Required for including images
\graphicspath{{Figures/}{./}} % Specifies where to look for included images
\RequirePackage{hyperref} % Required for including links
\RequirePackage{changepage}


%%
% Font stuff

% Encoding
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage[english]{babel}

% Set fonts
\RequirePackage[osf]{mathpazo} % Palatino with oldstyle figures
\newcommand\liningnums[1]{\fontfamily{ppl}\selectfont#1} % Enable switch to lining nums
\RequirePackage{amsmath, amssymb}
\RequirePackage{eulervm}
\RequirePackage{csquotes}
%\defaultfontfeatures{Ligatures=TeX} % To support LaTeX ligatures (`` and --)

% Letterspacing
\RequirePackage[
	activate={true,nocompatibility},
	final,
	tracking=true,
	kerning=true,
	spacing=true,
	factor=1100,
	stretch=10,
	shrink=10
]{microtype}

\SetTracking{encoding=*}{5}
\lsstyle

\newcommand\lsstylehelp[1]{\edef\MT@letterspace@{#1}\lsstyle} % Enable change to letterspacing
\newcommand{\hairsp}{\ifmmode\mskip1mu\else\kern0.083em\fi}
\renewcommand{\,}{\ifmmode\mskip1mu\else\kern0.167em\fi}

% Font sizes
\renewcommand\normalsize{%
	\@setfontsize\normalsize{11}{17}%
}
\renewcommand\large{%
	\@setfontsize\large{17}{22}
}
\renewcommand\small{%
	\@setfontsize\small{8.5}{14}%
}
\renewcommand\footnotesize{%
	\@setfontsize\small{8.5}{14}%
}

% Paragraph indentation
\setlength{\parindent}{0pt}
\setlength{\parskip}{8.5pt}


%%
% Title
\RequirePackage{titlesec}

\newcommand{\email}[1]{%
	\def \@email {#1}
}

\renewcommand{\maketitle}{\bgroup
	\begin{center}
		{\large\selectfont\liningnums\lsstylehelp{0} \@title\par}
		{\normalfont \@author}\\
		{\normalfont \@email}
		\vspace{-11pt}
	\end{center}
}


%%
% Abstract
\renewenvironment{abstract}{%
	\begin{center}
		\begin{adjustwidth}{0.5in}{0.5in}
			\normalfont%
			\textbf{\textit{Abstract\hairsp—\hairsp}}\ignorespaces
			}
			{%
		\end{adjustwidth}
		\vspace{-11pt}
	\end{center}
}


%%
% Headings

% Heading 1
\titleformat{\section} % Section type being modified
	{\normalfont\liningnums\lsstylehelp{50}\bfseries}
	{\thesection}{0.333em} % Space between the title and label
	{\MakeUppercase}
\titlespacing*{\section}{0pt}{2.5pt}{0pt}

% Heading 2
\titleformat{\subsection}
	{\normalfont\bfseries}
	{\thesubsection}{0.4em}{}
\titlespacing*{\subsection}{0pt}{0pt}{0pt}

% Heading 3
\titleformat{\subsubsection}
	{\normalfont\bfseries\itshape}
	{\textup{\thesubsubsection}}{0.4em}{}
\titlespacing*{\subsubsection}{0pt}{0pt}{0pt}

% Heading 4
\newcommand{\subsubsubsection}[1]{
	\textbf{\textit{#1}}\hairsp—\hairsp\ignorespaces
}


%%
% Captions
\RequirePackage{caption} % Required for customising captions
\DeclareCaptionFormat{letterspaced}{%
	\lsstylehelp{10}{%
			#1#2#3\par%
	}{}%
}
\captionsetup{format=letterspaced} % Use the letter spaced caption style by default
\captionsetup{margin=1in} % Margin on the left and right sides of captions
\captionsetup{justification=justified, singlelinecheck=false} % Left-align and justify captions
\captionsetup{font=small} % Reduce font size
\captionsetup{labelfont={bf,it}} % BoldItalic label and number
\DeclareCaptionLabelSeparator{emdash}{\hairsp—\hairsp} % Custom caption label separator
\captionsetup{labelsep=emdash} % Change the default colon between number and label to use the custom separator


%%
% Lists
\RequirePackage{enumitem} % Required for list customisation
\setlist{leftmargin=*, noitemsep, nolistsep} % No left margin and space around/within lists
\setlist[itemize]{label={\tiny\textsuperscript{\textbullet}}}


%%
% Tables
\RequirePackage{booktabs} % Required for better horizontal rules in tables
\RequirePackage{array} % Required for manipulating table columns
\newcolumntype{R}[1]{>{\raggedleft\arraybackslash}p{#1}} % Define a new right-aligned column type
\newcolumntype{L}[1]{>{\raggedright\arraybackslash}p{#1}} % Define a new left-aligned (no justification) column type
\newcolumntype{C}[1]{>{\centering\arraybackslash}p{#1}} % Define a new centred column type
\setlength\lightrulewidth{0.03em}


%%
% Footnotes
\RequirePackage[bottom]{footmisc} % Make footnotes flush w/ the bottom of the page
\setlength{\skip\footins}{17pt}
\setlength{\footnotesep}{8.5pt}

\RequirePackage{footnotebackref} % Add backreferencing
\makeatletter
\long\def\@makefntext#1{
	\lsstylehelp{10}{
		{\footnotesize\@thefnmark~#1} % Footnote text position and width
	}
}
\makeatother


%%
% References
\RequirePackage[
	bibstyle=authoryear,
	dashed=false,
	sorting=nyt,
	natbib=true,
	maxbibnames=99
]{biblatex}

\DeclareFieldFormat{bibentrysetcount}{\mkbibparens{\mknumalph{#1}}}
\DeclareFieldFormat{labelnumberwidth}{\mkbibbrackets{#1}}

\defbibenvironment{bibliography}
	{\list
		{\printtext[labelnumberwidth]{%
			\printfield{prefixnumber}%
			\printfield{labelnumber}}
		}%
		{\setlength{\labelwidth}{\labelnumberwidth}%
		\setlength{\leftmargin}{\labelwidth}%
		\setlength{\labelsep}{\biblabelsep}%
		\addtolength{\leftmargin}{\labelsep}%
		\setlength{\itemsep}{\bibitemsep}%
		\setlength{\parsep}{\bibparsep}}%
		\renewcommand*{\makelabel}[1]{\hss##1}}
	{\endlist}
	{\item}

\DeclareNameAlias{sortname}{family-given}

% Inline citations
\renewcommand{\cite}[1]{ \citeauthor{#1}, \citeyear{#1}}
\renewcommand{\citep}[1]{ (\citeauthor{#1}, \citeyear{#1})}


%%
% Metadata
\RequirePackage{xcolor} % Required for defining custom colours
\definecolor{linkBlue}{cmyk}{100,50,0,0}
\hypersetup{
	pdftitle={@title},
	pdfauthor={@author},
	% bookmarks=true,
	% bookmarksopen=true,
	pdfpagemode=UseOutlines,
	colorlinks,
	citecolor=linkBlue,
	urlcolor=linkBlue,
	linkcolor=linkBlue
}