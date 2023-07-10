" ==================
" Idea
" ==================
" This configuration is used for the ideavimc in jetbrains editors

" ==================
" Settings
" ==================

so ~/dotfiles/nvim/common.vim

set foldmethod=syntax

" Navigate splits with C-hjkl
nmap <silent> <C-k> <C-w><up>
nmap <silent> <C-j> <C-w><down>
nmap <silent> <C-h> <C-w><left>
nmap <silent> <C-l> <C-w><right>

nmap <silent> <c-s-k> <C-W>k
nmap <silent> <c-s-j> <C-W>j
nmap <silent> <c-s-h> <C-W>h
nmap <silent> <c-s-l> <C-W>l

nmap zx jjzzll


nnoremap \ :noh<CR>

" Idea bindings
nmap <leader>rn <Action>(RenameElement)
nmap <leader>b <Action>(ToggleLineBreakpoint)
nmap <leader>t <Action>(ExpressionTypeInfo)
nmap <leader><leader> <Action>(RecentFiles)

nmap <leader>t <Action>(GotoTest)

nmap <leader>m <Action>(MainMenu)
nmap <leader>z <Action>(HideAllWindows)
nmap <leader>x <Action>(MaximizeEditorInSplit)
nmap <leader>X :only<CR>

nmap gu <action>(FindUsages)
nmap gm <Action>(MainMenu)
nmap gz <Action>(HideAllWindows)
nmap gx <Action>(MaximizeEditorInSplit)
nmap gX :only<CR>

" gray out the icon
set ideastatusicon=gray

set NERDTree
set commentary
set surround
set ideamarks

set ideajoin