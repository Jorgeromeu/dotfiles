" ==================
" Minimal
" ==================
" This is the vanilla vim configuration. It maintains all of my settings,
" keybindigs, and so on but removes all plugins. It is fully compatible with
" vanilla vim


" ==================
" Runtime
" ==================
set runtimepath^=~/dotfiles/nvim/runtime runtimepath+=~/dotfiles/nvim/runtime/after runtimepath+=~/dotfiles/nvim/runtime/autoload 
let &packpath=&runtimepath

" ==================
" Settings
" ==================

" get general settings
so ~/dotfiles/nvim/settings/general.vim
so ~/dotfiles/nvim/settings/keys.vim

