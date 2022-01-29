" Basic settings
so ~/dotfiles/nvim/common.vim

" Plugins
call plug#begin('~/dotfiles/nvim/runtime/plugged')
" simple things
Plug 'vim-scripts/restore_view.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'

" aesthetics
Plug 'arcticicestudio/nord-vim'
Plug 'itchyny/lightline.vim'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'

" langs
Plug 'sheerun/vim-polyglot'
Plug 'plasticboy/vim-markdown'
call plug#end()

so ~/dotfiles/nvim/modules/markdown.vim
so ~/dotfiles/nvim/modules/commentary.vim
so ~/dotfiles/nvim/modules/lightline.vim
so ~/dotfiles/nvim/modules/nord.vim

