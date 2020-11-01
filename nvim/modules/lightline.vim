set noshowmode
let g:lightline = {
    \ 'colorscheme': 'nord',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'cocgit', 'cocstatus', 'readonly', 'filename', 'modified'] ],
	\	
	\   'right': [['bufnum'], [ 'fileformat', 'fileencoding', 'filetype' ]]
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

