#!/usr/bin/env bash
# desc: symlink herdr config into ~/.config/herdr
set -eu
HERE="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
MOD_DIR="$(cd "$HERE/.." && pwd)"
source "$HERE/../../lib.sh"

link "$MOD_DIR/config.toml" "$HOME/.config/herdr/config.toml"

if ! command -v herdr >/dev/null; then
    echo
    echo "note: herdr is not installed on this host."
else
    herdr server reload-config >/dev/null 2>&1 || true
fi
