" ==================
" BASIC SETTINGS
" ==================
set nocompatible

" basic usability settings
set hidden
set wildmenu
set mouse=a
set laststatus=2
set noswapfile
set visualbell
set lazyredraw
filetype plugin on
syntax enable

" indentation settings
set tabstop=4
set shiftwidth=4
set backspace=indent,eol,start

" line numbers
set number
set relativenumber

" search
set hlsearch
set incsearch
set ignorecase
set smartcase

" sensible splits
set splitbelow
set splitright

" folding
set foldcolumn=3

if has('nvim')
	set foldcolumn=auto:9
endif

set nofoldenable

" word wrap
set formatoptions=l
set breakindent
set linebreak
set nowrap

" path
set path+=**

" netrw
let g:netrw_banner=0		" disable banner
let g:netrw_liststyle=3 	" tree view
let g:netrw_winsize = 25

let g:netrw_browse_split = 2 " open in vertical split
