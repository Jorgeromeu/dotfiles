" ==================
" Minimal
" ==================
" This is the vanilla vim configuration. It maintains all of my settings,
" keybindigs, and so on but removes all plugins. It is fully compatible with
" vanilla vim

" General Settings
execute 'source' fnameescape(fnamemodify(resolve(expand('<sfile>:p')), ':h') . '/common.vim')

colo industry
set foldmethod=syntax
