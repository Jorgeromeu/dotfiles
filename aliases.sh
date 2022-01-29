alias sudo='sudo '

# shorteneed commands
alias v='nvim'
alias g='git'
alias pm='pacman'
alias spm='sudo pacman'
alias ytdl='youtube-dl'
alias cl='clear'
alias ipy='ipython'
alias py='python'
alias arr='R' # "arr" is easier to type than R imo
alias hd='hexdump'
alias xopen='xdg-open'
alias sysd='systemctl'
alias antlr='antlr4'
alias pypy='pypy3'
alias docker='sudo docker'
alias e='emacs -nw'
alias eg='emacs'
alias scrnkey='screenkey -t 0.25 --persist --opacity 0 --font-color black'

# instead of ls im using exa
alias ll='exa -F --group-directories-first -l --git'
alias la='exa -F --color=auto --group-directories-first -a'

# default options
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -v'
alias ls='exa -F --color=auto --group-directories-first'
alias grep="grep --color=auto"
alias gcc="gcc -no-pie -Wall -g"
alias g++="g++ -no-pie -Wall -g"
alias gdb="gdb -q"
alias make="make -k"
