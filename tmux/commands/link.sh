#!/usr/bin/env bash
# desc: symlink tmux config into $HOME
set -eu
HERE="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
MOD_DIR="$(cd "$HERE/.." && pwd)"
source "$HERE/../../lib.sh"

link "$MOD_DIR/main.tmux" "$HOME/.tmux.conf"

if ! command -v tmux >/dev/null; then
    echo
    echo "note: tmux is not installed on this host."
fi
