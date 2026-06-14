#!/usr/bin/env bash
# desc: symlink a vim profile to ~/.vimrc and ~/.config/nvim/init.vim (pass profile name; no args lists profiles)
set -eu
HERE="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
MOD_DIR="$(cd "$HERE/.." && pwd)"
source "$HERE/../../lib.sh"

list_profiles() {
    echo "available profiles:"
    for f in "$MOD_DIR"/*.vim; do
        [ -e "$f" ] || continue
        name="$(basename "$f" .vim)"
        echo "  $name"
    done
}

if [ "$#" -eq 0 ]; then
    echo "usage: $0 <profile>"
    echo
    list_profiles
    exit 0
fi

profile="$1"
src="$MOD_DIR/$profile.vim"
if [ ! -f "$src" ]; then
    echo "no such profile: $profile"
    echo
    list_profiles
    exit 1
fi

link "$src" "$HOME/.vimrc"
link "$src" "$HOME/.config/nvim/init.vim"
