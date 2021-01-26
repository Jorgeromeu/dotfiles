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

nnoremap \ :noh
set surround

" CoC mappings
nmap <leader>rn :action RenameElement<CR>
