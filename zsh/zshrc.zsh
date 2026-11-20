# utf8
LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8

# Prompt
# ======
# Starship if installed (config: the starship module); otherwise a plain zsh fallback.
if command -v starship >/dev/null; then
  export VIRTUAL_ENV_DISABLE_PROMPT=1   # starship shows the venv itself
  export CONDA_CHANGEPS1=false
  eval "$(starship init zsh)"

  # Alt-i toggles the verbose config (default: ~/.config/starship.toml).
  prompt-verbose() {
    if [[ -n $STARSHIP_CONFIG ]]; then
      unset STARSHIP_CONFIG
    else
      export STARSHIP_CONFIG=~/.config/starship-verbose.toml
    fi
    zle reset-prompt
  }
  zle -N prompt-verbose
  bindkey -M viins '^[i' prompt-verbose
  bindkey -M vicmd '^[i' prompt-verbose
else
  # [exit code] [⎇ branch] ~/path
  autoload -Uz vcs_info
  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:git:*' formats '%B%F{yellow}⎇ %b%f '
  precmd_functions+=( vcs_info )
  setopt prompt_subst
  PROMPT='%(?..%B%F{red}%?%f%b )${vcs_info_msg_0_}%B%F{blue}%5~%f%b '
fi


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
source ${${(%):-%x}:A:h}/aliases.sh   # next to this file's real path, wherever the repo is

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
export PATH="$HOME/texlive/2026/bin/x86_64-linux:$PATH"

# snap binaries (WSL starts non-login shells, so /etc/profile.d/apps-bin-path.sh never runs)
export PATH="$PATH:/snap/bin"

# uvactivate (activate the venv uv would pick for $PWD: workspace root, or a standalone project)
uvactivate() {
  local py bin
  py=$(env -u VIRTUAL_ENV uv python find "$@") || return   # ignore any already-active venv
  bin=${py:h}
  [[ -f $bin/activate ]] || { print -u2 "uvactivate: no project venv for $PWD (run 'uv sync')"; return 1 }
  (( $+functions[deactivate] )) && deactivate
  source $bin/activate
  print "activated $VIRTUAL_ENV"
}

# Worktrees
# =========
# `wtcd <name>` cds into a worktree of the current repo by its directory name
# (the main checkout goes by the repo's name); tab-completes the names with each
# one's branch and path alongside.

# One "name<TAB>branch<TAB>path" line per worktree of the current repo.
_wt_list() {
  local line dir branch
  git worktree list --porcelain 2>/dev/null | while read -r line; do
    case $line in
      worktree\ *) dir=${line#worktree } ;;
      branch\ *)   branch=${line#branch refs/heads/} ;;
      detached)    branch='(detached)' ;;
      bare)        branch='(bare)' ;;
      '')          print -r -- "${dir:t}"$'\t'"$branch"$'\t'"$dir"; branch= ;;
    esac
  done
}
wtcd() {
  git rev-parse --git-dir >/dev/null 2>&1 || { print -u2 "wtcd: not in a git repo"; return 1 }
  (( $# )) || { print -u2 "usage: wtcd <worktree>"; git worktree list >&2; return 1 }
  local name branch dir
  while IFS=$'\t' read -r name branch dir; do
    [[ $name == $1 ]] && { cd -- $dir; return }
  done < <(_wt_list)
  print -u2 "wtcd: no worktree '$1' in this repo"; return 1
}
_wtcd() {
  (( CURRENT == 2 )) || return 1  # wtcd takes a single worktree name
  local -a names branches dirs items
  local name branch dir i
  while IFS=$'\t' read -r name branch dir; do
    names+=$name; branches+=$branch; dirs+=${(D)dir}
  done < <(_wt_list)
  (( $#names )) || return 1
  local w=${#${(O@)branches//?/X}[1]}  # longest branch, to align the path column
  for i in {1..$#names}; do items+=("${names[i]}:${(r:w:)branches[i]}  ${dirs[i]}"); done
  _describe worktree items
}
compdef _wtcd wtcd
