" call plug#begin('~/dotfiles/nvim/runtime/plugged')
" Plug 'itchyny/lightline.vim'
" Plug 'junegunn/goyo.vim'
" Plug 'arcticicestudio/nord-vim'
" call plug#end()

colo nord

let g:nord_bold = 1
let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_underline = 1

set noshowmode
let g:lightline = {
    \ 'colorscheme': 'nord',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'cocgit', 'cocstatus', 'readonly', 'filename', 'modified', 'pwd' ] ],
	\	
	\   'right': [['bufnum'], [ 'fileformat', 'fileencoding', 'filetype' ], ['absolutepath']]
	\	},
    \ 'component_function': {
	\   'cocstatus': 'coc#status',
	\   'cocgit': 'CocGit'
    \ },
    \ }


function! CocGit() abort
  let blame = get(g:, 'coc_git_status', '')
  " return blame
  return winwidth(0) > 10 ? blame : ''
endfunction

