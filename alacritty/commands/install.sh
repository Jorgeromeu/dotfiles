#!/usr/bin/env bash
# desc: symlink alacritty config into ~/.config/alacritty
set -eu
HERE="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
MOD_DIR="$(cd "$HERE/.." && pwd)"
source "$HERE/../../lib.sh"

link "$MOD_DIR/alacritty.yml" "$HOME/.config/alacritty/alacritty.yml"

if ! command -v alacritty >/dev/null; then
    echo
    echo "note: alacritty is not installed on this host."
fi
