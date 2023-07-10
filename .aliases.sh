alias sudo='sudo '

# python...
alias ipy='ipython'
alias pypy='pypy3'
alias py='python'
alias py39='python3.9'
alias ipy39='ipython3.9'
alias py36='python3.6'
alias ipy36='ipython3.6'

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
alias scrnkey='screenkey -t 0.25 --persist --opacity 0 --font-color black'

# replace 'ls' with exa + parameters
alias ls='exa -F --group-directories-first --git'
alias ll='exa -F --group-directories-first -l --git'
alias la='exa -F --color=auto --group-directories-first -a'

# default options
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -v'
alias grep="grep --color=auto"
alias gcc="gcc -no-pie -Wall -g"
alias g++="g++ -no-pie -Wall -g"
alias gdb="gdb -q"
alias make="make -k"
