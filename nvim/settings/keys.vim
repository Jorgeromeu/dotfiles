" ==================
" MAPPINGS
" ==================

" avoid the esc key
inoremap jj <Esc>

" leader mapping
let mapleader = " "

" remap leader to clear search
nnoremap <silent> \ :noh \| echo<CR>

" split navigation
" nnoremap <C-J> <C-W><C-J>
" nnoremap <C-K> <C-W><C-K>
" nnoremap <C-L> <C-W><C-L>
" nnoremap <C-H> <C-W><C-H>

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
