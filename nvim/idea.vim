" ==================
" Idea
" ==================
" This configuration is used for the ideavimc in jetbrains editors

" ==================
" Settings
" ==================

so ~/dotfiles/nvim/settings/general.vim
so ~/dotfiles/nvim/settings/keys.vim

set foldmethod=syntax

nnoremap \ :noh<CR>

set norelativenumber

" custom bindings
nmap <leader>rn <Action>(RenameElement)
nmap <leader>b <Action>(ToggleLineBreakpoint)
nmap <leader>t <Action>(ExpressionTypeInfo)
nmap <leader><leader> <Action>(RecentFiles)

nmap gm <Action>(MainMenu)
nmap gz <Action>(HideAllWindows)

" nmap gb :action Back<cr>
" nmap gf :action Forward<cr>

set ideastatusicon=gray

set NERDTree
set commentary
set surround
set ideamarks
