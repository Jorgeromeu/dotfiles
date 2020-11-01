" ==================
" Runtime
" ==================
" This configuration is the most bloated. It includes several plugins, many of
" which are aesthetic / require external dependncies, the configuration breaks support
" for vanilla vim, requries nvim (for correct functioning). This is the configuratio I 
" use on my local machine

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
Plug 'sirver/UltiSnips'
Plug 'plasticboy/vim-markdown'
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/goyo.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

so ~/dotfiles/nvim/modules/commentary.vim
so ~/dotfiles/nvim/modules/ultisnips.vim
so ~/dotfiles/nvim/modules/markdown.vim
so ~/dotfiles/nvim/modules/fzf.vim
so ~/dotfiles/nvim/modules/lightline.vim
so ~/dotfiles/nvim/modules/goyo.vim
so ~/dotfiles/nvim/modules/nord.vim
so ~/dotfiles/nvim/modules/coc.vim

" ==================
" Settings
" ==================

so ~/dotfiles/nvim/settings/general.vim
so ~/dotfiles/nvim/settings/keys.vim

