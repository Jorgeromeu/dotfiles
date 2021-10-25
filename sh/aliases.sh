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

# emacs
alias e='emacs -nw'
alias eg='emacs'

# screenkey
alias scrnkey='screenkey -t 0.25 --persist --opacity 0 --font-color black'

# default options
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -v'
# use nvim as less
alias less="nvim -c 'set nonumber laststatus=0' -"
alias ls='exa --color=auto --group-directories-first'
alias ll='exa --group-directories-first -l --git'
alias la='exa --color=auto --group-directories-first -a'
alias grep="grep --color=auto"
alias gcc="gcc -no-pie -Wall -g"
alias gdb="gdb -q"
alias cgdb="cgdb -q"
alias make="make -k"

