alias sudo='sudo '

# python things
alias py='python'
alias pip='pip3.10'
alias ipy='ipython --profile="jorge"'
alias pypy='pypy3'

# shorteneed commands
alias v='nvim'
alias g='git'
alias pm='pacman'
alias spm='sudo pacman'
alias ytdl='youtube-dl'
alias cl='clear'
alias hd='hexdump' # though i use hx instead
alias xopen='xdg-open'
alias sysd='systemctl'
alias antlr='antlr4'
alias docker='sudo docker'
alias e='emacs -nw'
alias eg='emacs'

# replace 'ls' with exa + parameters
alias ls='exa -F --group-directories-first --git'
alias ll='exa -F --group-directories-first -l --git'
alias la='exa -F --color=auto --group-directories-first -a'

# default parameters on common commands 
alias cp='cp -v'
alias du='du -h'
alias mv='mv -v'
alias rm='rm -v'
alias grep="grep --color=auto"
alias gcc="gcc -no-pie -Wall -g"
alias g++="g++ -no-pie -Wall -g"
alias gdb="gdb -q"
alias make="make -k"

# common commands with a bunch of args
alias scrnkey='screenkey -t 0.25 --persist --opacity 0 --font-color black'
alias lxmk='latexmk -interaction=nonstopmode -pvc -pdf'
