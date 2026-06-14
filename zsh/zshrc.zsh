# Simple prompt with git info
# ===========================
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' formats '%B%F{yellow}%b%f'
zstyle ':vcs_info:*' enable git

# utf8
LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8

# Build the prompt from only the non-empty segments, joined with a single
# space. ${(j: :)parts} guarantees exactly one space between parts and no
# leading/trailing space; the explicit trailing space is added after.
build_prompt() {
  local exit_code=$?
  vcs_info
  local -a parts
  (( exit_code ))             && parts+="%B%F{red}${exit_code}%f%b"   # exit code
  [[ -n $SSH_CONNECTION ]]    && parts+="%F{magenta}%m%f"             # hostname (SSH only)
  [[ -n $vcs_info_msg_0_ ]]   && parts+="$vcs_info_msg_0_"            # git branch
  parts+="%B%F{blue}%5~%f%b"                                          # working dir
  PROMPT="${(j: :)parts} "
}
precmd_functions+=( build_prompt )


# Vim bindings
# ============
bindkey -v
bindkey -M viins 'jj' vi-cmd-mode
bindkey '^R' history-incremental-search-backward
export KEYTIMEOUT=20

# Big History
# =======
HISTSIZE=1000000000
SAVEHIST=1000000000
HISTFILE=~/.zshhistory

# Aliases
# =======
source ~/dotfiles/zsh/aliases.sh

# Fancy tab complete
# ============
autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zmodload zsh/complist
compinit
_comp_options+=(globdots)
# Tab cycles through matches; Shift-Tab goes backward
bindkey '^I' menu-complete
bindkey '^[[Z' reverse-menu-complete

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


# Syntax highlighting (via plugin)
# ================================
source ~/dotfiles/zsh/zsh-syntax-hl/zsh-syntax-highlighting.zsh

# Load env variables
source ~/.profile

# opam configuration
[[ ! -r /home/jorge/.opam/opam-init/init.zsh ]] || source /home/jorge/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

[ -f "/home/jorge/.ghcup/env" ] && source "/home/jorge/.ghcup/env" # ghcup-env

# zoxide (smart cd)
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"

# fzf (fuzzy finder shell integration; installed via `fzf --install`)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# nvm (node version manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"