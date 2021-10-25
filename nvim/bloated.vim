" ==================
" Bloated
" ==================
" This configuration is the most bloated. It includes several plugins, many of
" which are aesthetic / require external dependncies, the configuration breaks support
" for vanilla vim, requries nvim (for correct functioning). 
"
" In order to function correctly, pynvim 

" ==================
" Runtime
" ==================
set runtimepath^=~/dotfiles/nvim/runtime runtimepath+=~/dotfiles/nvim/runtime/after runtimepath+=~/dotfiles/nvim/runtime/autoload
let &packpath=&runtimepath

" ==================
" Settings
" ==================

so ~/dotfiles/nvim/settings/general.vim
so ~/dotfiles/nvim/settings/keys.vim

" ==================
" Plugins
" ==================
call plug#begin('~/dotfiles/nvim/runtime/plugged')
" vimscript
Plug 'vim-scripts/restore_view.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'

" aesthetics
Plug 'arcticicestudio/nord-vim'
Plug 'itchyny/lightline.vim'

" require dependencies
Plug 'sirver/UltiSnips'  
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" languages
Plug 'plasticboy/vim-markdown'
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'justinmk/vim-syntax-extra'
Plug 'calculuswhiz/vim-GAS-x86_64-highlighter'
Plug 'lark-parser/vim-lark-syntax'
Plug 'kmyk/brainfuck-highlight.vim', { 'autoload' : { 'filetypes' : 'brainfuck' } }
Plug 'sheerun/vim-polyglot'
call plug#end()

so ~/dotfiles/nvim/modules/commentary.vim
so ~/dotfiles/nvim/modules/ultisnips.vim
so ~/dotfiles/nvim/modules/markdown.vim
so ~/dotfiles/nvim/modules/fzf.vim
so ~/dotfiles/nvim/modules/lightline.vim
so ~/dotfiles/nvim/modules/nord.vim
so ~/dotfiles/nvim/modules/coc.vim

" Filetype specific settings
autocmd Filetype markdown call SetProse()
autocmd Filetype tex call SetProse()

autocmd FileType c set foldmethod=syntax
autocmd FileType cpp set foldmethod=syntax
autocmd FileType java set foldmethod=syntax

command Prose execute SetProse()

function SetProse()
	so ~/dotfiles/nvim/settings/prose.vim
	set nonumber
	set norelativenumber
endfunction

