#!/usr/bin/env bash
# desc: symlink starship configs (minimal + verbose) into ~/.config
set -eu
HERE="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
MOD_DIR="$(cd "$HERE/.." && pwd)"
source "$HERE/../../lib.sh"

link "$MOD_DIR/starship.toml" "$HOME/.config/starship.toml"
link "$MOD_DIR/starship-verbose.toml" "$HOME/.config/starship-verbose.toml"

if ! command -v starship >/dev/null; then
    echo
    echo "note: starship is not installed on this host."
fi
