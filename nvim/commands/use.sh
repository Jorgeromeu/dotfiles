#!/usr/bin/env bash
# desc: pick this host's vim profile, e.g. `use minimal` (writes ~/.config/nvim/profile)
set -eu
PROFILE_FILE="$HOME/.config/nvim/profile"

profiles() { for f in "$MOD_DIR"/*.vim; do n="$(basename "$f" .vim)"; [ "$n" != init ] && echo "$n"; done; }

if [ "$#" -eq 0 ]; then
    echo "current: $(cat "$PROFILE_FILE" 2>/dev/null || echo 'common (default)')"
    echo "profiles: $(profiles | tr '\n' ' ')"
    exit 0
fi
profiles | grep -qx "$1" || { echo "no such profile: $1 (profiles: $(profiles | tr '\n' ' '))" >&2; exit 1; }
mkdir -p "$(dirname "$PROFILE_FILE")"
echo "$1" > "$PROFILE_FILE"
echo "profile set to $1"
