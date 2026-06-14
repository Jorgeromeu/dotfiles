# Simple prompt with git info
# ===========================
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' formats '%B%F{yellow}%b%f'
zstyle ':vcs_info:*' enable git

# Let build_prompt own the env segment instead of the tools munging PROMPT
# themselves (build_prompt rebuilds PROMPT every prompt and would clobber it).
export VIRTUAL_ENV_DISABLE_PROMPT=1
export CONDA_CHANGEPS1=false

# Name of the active dev environment (python venv, conda, etc.), or empty.
prompt_env_name() {
  if [[ -n $VIRTUAL_ENV ]]; then
    echo "${VIRTUAL_ENV:t}"                                   # python venv / poetry / uv
  elif [[ -n $CONDA_DEFAULT_ENV ]]; then
    echo "${CONDA_DEFAULT_ENV:t}"                             # conda / mamba
  fi
}

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
  local env_name="$(prompt_env_name)"
  (( exit_code ))             && parts+="%B%F{red}${exit_code}%f%b"   # exit code
  [[ -n $env_name ]]          && parts+="%B%F{green}(${env_name})%f%b"  # dev env (venv/conda)
  [[ -n $SSH_CONNECTION ]]    && parts+="%B%F{magenta}%m%f%b"         # hostname (SSH only)
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

# fzf (fuzzy finder shell integration: Ctrl-R history, Ctrl-T files, Alt-C cd)
if command -v fzf >/dev/null; then
  if fzf --zsh >/dev/null 2>&1; then
    source <(fzf --zsh)                                   # fzf >= 0.48
  elif [ -d /usr/share/doc/fzf/examples ]; then
    source /usr/share/doc/fzf/examples/key-bindings.zsh   # Debian/Ubuntu pkg
    source /usr/share/doc/fzf/examples/completion.zsh
  elif [ -d /usr/share/fzf ]; then
    source /usr/share/fzf/key-bindings.zsh                # Arch pkg
    source /usr/share/fzf/completion.zsh
  elif [ -f ~/.fzf.zsh ]; then
    source ~/.fzf.zsh                                     # git-clone install
  fi
fi

# nvm (node version manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"