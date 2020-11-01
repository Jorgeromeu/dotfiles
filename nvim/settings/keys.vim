" ==================
" MAPPINGS
" ==================

" avoid the esc key
imap jj <Esc>

" leader mapping
let mapleader = ","

" quick navigation between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" quick save
map <C-s> :wa<CR>

" reload vimrc
map <leader>r :so ~/.vimrc<CR> 

" swap lines
map K :norm ddkkp<CR>
map J :norm ddp<CR>

" fast indenting
map <S-H> <<
map <S-L> >>

" spellcheck
setlocal spelllang=en_gb
nnoremap <leader>s :set spell<CR>
imap <C-k> <Esc>mz[sz=1<CR>`zi

" easily change filetype
map <leader>ft :set filetype=

" copy and paste to the system clipboard
vnoremap <C-c> "+y
vnoremap <C-x> "+x

" Y behaves like D anc C, ...
map Y y$

"clear prompt also clears highlight
nnoremap <silent> ; :noh<CR> 

" cursorline and cursorcolumn
map <leader>- :set invcursorline<CR>
map <leader>\ :set invcursorcolumn<CR>

