" call plug#begin('~/dotfiles/nvim/runtime/plugged')
" Plug 'itchyny/lightline.vim'
" Plug 'junegunn/goyo.vim'
" Plug 'arcticicestudio/nord-vim'
" call plug#end()

colo nord

let g:nord_bold = 1
let g:nord_italic = 1
let g:nord_underline = 1

set noshowmode
let g:lightline = {
    \ 'colorscheme': 'nord',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'gitbranch#name'
    \ },
    \ }
