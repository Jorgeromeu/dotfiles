# Aliases. Tool-specific blocks are gated on `command -v` so this file is
# safe to source on any host: aliases for missing tools simply don't activate.

# ----- always on -----
alias sudo='sudo '          # let aliases expand after sudo
alias g='git'
alias cl='clear'
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -v'
alias du='du -h'
alias grep='grep --color=auto'
alias make='make -k'

# ----- ls family -----
# prefer exa when available, fall back to plain ls otherwise
if command -v exa >/dev/null; then
    alias ls='exa -F --group-directories-first --git'
    alias ll='exa -F --group-directories-first -l --git'
    alias la='exa -F --color=auto --group-directories-first -a'
else
    alias ls='ls --color=auto'
    alias ll='ls -alF --color=auto'
    alias la='ls -A --color=auto'
fi

# ----- neovim -----
if command -v nvim >/dev/null; then
    alias v='nvim'
fi

# python 
if command -v python >/dev/null; then
    alias py='python'
fi
if command -v python3 >/dev/null; then
    alias py3='python3'
fi
if command -v ipython >/dev/null; then
    alias ipy='ipython'
fi

# arch / pacman 
if command -v pacman >/dev/null; then
    alias pm='pacman'
    alias spm='sudo pacman'
fi

# gdb / gcc tweaks
if command -v gdb >/dev/null; then
    alias gdb='gdb -q'
fi
if command -v gcc >/dev/null; then
    alias gcc='gcc -no-pie -Wall -g'
fi
if command -v g++ >/dev/null; then
    alias g++='g++ -no-pie -Wall -g'
fi

# misc utilities 
if command -v xdg-open >/dev/null; then
    alias xopen='xdg-open'
fi
if command -v docker >/dev/null; then
    alias docker='sudo docker'
fi