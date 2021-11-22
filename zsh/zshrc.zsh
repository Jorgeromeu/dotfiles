# Simple prompt with git info
# ===========================
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
zstyle ':vcs_info:git:*' formats '%B%F{yellow}[%b]%f'
zstyle ':vcs_info:*' enable git

git="\$vcs_info_msg_0_%b"
err='%(?..%B%F{red}[%?]%f%b)'
wd='%B%F{blue}[%5~]%f%b'

gits="\$vcs_info_msg_0_%b"
errs='%(?..%B%F{red}%?%f%b)'
wds='%B%F{blue}%5~%f%b'

PROMPT="${err}${git}${wd} "


# Vim bindings
# ============
bindkey -v
bindkey -M viins 'jj' vi-cmd-mode
bindkey '^R' history-incremental-search-backward
export KEYTIMEOUT=20

# History
# =======
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE=~/.zshhistory

# Aliases
# =======
source ~/dotfiles/aliases.sh

# Automatically "ls"
# =================
function chpwd() {
    emulate -L zsh
    ls 
}

# Tab complete
# ============
autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zmodload zsh/complist
compinit
_comp_options+=(globdots)


# Change cursor shape for different vi modes.
# ==========================================
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.


# Syntax highlighting
# ===================
source ~/dotfiles/zsh/zsh-syntax-hl/zsh-syntax-highlighting.zsh

# Load env variables
source ~/.profile

