" ==================
" Hybrid
" ==================
" this configuration is a hybrid of the bloated and minimal confiurations
" plugins which have no provide useful functionality and have no dependenceis
" are kept, plugins which are purely aesthetic or require python/node/... are
" removed. This configuration is fully compatible with standard vim

" ==================
" Runtime	
" ==================
set runtimepath^=~/dotfiles/nvim/runtime runtimepath+=~/dotfiles/nvim/runtime/after runtimepath+=~/dotfiles/nvim/runtime/autoload 
let &packpath=&runtimepath

" ==================
" Plugins
" ==================
call plug#begin('~/dotfiles/nvim/runtime/plugged')
Plug 'jiangmiao/auto-pairs'
Plug 'vim-scripts/restore_view.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'plasticboy/vim-markdown'
call plug#end()

so ~/dotfiles/nvim/modules/commentary.vim
so ~/dotfiles/nvim/modules/markdown.vim

" ==================
" Settings
" ==================

so ~/dotfiles/nvim/settings/general.vim
so ~/dotfiles/nvim/settings/keys.vim

