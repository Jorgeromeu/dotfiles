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
set expandtab

" line numbers
set number

" search
set hlsearch
set incsearch
set ignorecase
set smartcase

" sensible splits
set splitbelow
set splitright

" folding
" set foldcolumn=3

" if has('nvim')
" 	set foldcolumn=auto:9
" endif
set nofoldenable

" word wrap
set formatoptions=l
set breakindent
set linebreak
set nowrap

" path
set path+=**

" netrw
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_winsize=25
let g:netrw_browse_split=2

" MAPPINGS
" ==================

" avoid the esc key
inoremap jj <Esc>

" leader mapping
let mapleader = " "

" remap \ to clear search
nnoremap <silent> \ :noh \| echo<CR>

" quick save
map <C-s> :wa<CR>

" easily change filetype
map <leader>ft :set filetype=

" copy and paste to the system clipboard
vnoremap <C-c> "+y
vnoremap <C-x> "+x

" Y behaves like D anc C, ...
map Y y$

" cursorline and cursorcolumn
map <leader>- :set invcursorline<CR>
map <leader>\ :set invcursorcolumn<CR>

