" ==================
" Vscode
" ==================
" this configuration is used when I want to run embeded nvim in vscode vscode in 

" ==================
" Runtime	
" ==================
set runtimepath^=~/dotfiles/nvim/runtime runtimepath+=~/dotfiles/nvim/runtime/after runtimepath+=~/dotfiles/nvim/runtime/autoload 
let &packpath=&runtimepath

" ==================
" Plugins
" ==================
call plug#begin('~/dotfiles/nvim/runtime/plugged')
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
call plug#end()

so ~/dotfiles/nvim/modules/commentary.vim
so ~/dotfiles/nvim/modules/markdown.vim

" ==================
" Settings
" ==================

so ~/dotfiles/nvim/settings/general.vim
so ~/dotfiles/nvim/settings/keys.vim

