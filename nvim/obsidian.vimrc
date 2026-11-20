" ==================
" Obsidian vimrc
" ==================
" For the Obsidian Vimrc Support plugin: copy into a vault as .obsidian.vimrc.
" Not a vim profile (Obsidian only understands a subset of vimscript).

imap jj <Esc>

" Have j and k navigate visual lines rather than logical ones
nmap j gj
nmap k gk

nmap \ :noh

exmap unfoldall obcommand editor:unfold-all
nmap zR :unfoldall

exmap foldall obcommand editor:fold-all
nmap zM :foldall

exmap foldtoggle obcommand editor:toggle-fold
nmap za :foldtoggle
