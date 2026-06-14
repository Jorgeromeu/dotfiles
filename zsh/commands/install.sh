#!/usr/bin/env bash
# desc: symlink zsh config into $HOME
set -eu
HERE="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
MOD_DIR="$(cd "$HERE/.." && pwd)"
source "$HERE/../../lib.sh"

link "$MOD_DIR/zshrc.zsh" "$HOME/.zshrc"

if ! command -v zsh >/dev/null; then
    echo
    echo "note: zsh is not installed on this host."
fi
