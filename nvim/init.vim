" Entry point for both vim (~/.vimrc) and neovim (~/.config/nvim/init.vim).
" Loads this host's profile, named in ~/.config/nvim/profile (default: common).
" Switch with: ./dot.sh nvim use <profile>
let s:dir = fnamemodify(resolve(expand('<sfile>:p')), ':h')
let s:file = expand('~/.config/nvim/profile')
let s:profile = filereadable(s:file) ? get(readfile(s:file), 0, 'common') : 'common'
execute 'source' fnameescape(s:dir . '/' . s:profile . '.vim')
