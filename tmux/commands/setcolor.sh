#!/usr/bin/env bash
# desc: set this host's tmux accent color (writes ~/.tmux.local.conf)
set -eu

LOCAL_CONF="$HOME/.tmux.local.conf"

if [ "$#" -eq 0 ]; then
    echo "usage: ./dot.sh tmux setcolor <color>"
    echo
    echo "examples: blue, red, green, yellow, magenta, cyan, white,"
    echo "          colour208, '#ff8800'"
    if [ -f "$LOCAL_CONF" ]; then
        echo
        echo "current ($LOCAL_CONF):"
        sed 's/^/  /' "$LOCAL_CONF"
    fi
    exit 0
fi

color="$1"

# Rewrite (or create) the local override file. Keep it simple: one setting per
# line, replace any existing @active_window_color line in place.
tmpfile="$(mktemp)"
trap 'rm -f "$tmpfile"' EXIT

if [ -f "$LOCAL_CONF" ]; then
    grep -v '^set -g @active_window_color ' "$LOCAL_CONF" > "$tmpfile" || true
fi
printf 'set -g @active_window_color "%s"\n' "$color" >> "$tmpfile"
mv "$tmpfile" "$LOCAL_CONF"
trap - EXIT

echo "wrote $LOCAL_CONF:"
sed 's/^/  /' "$LOCAL_CONF"

# Apply live if a tmux server is running.
if command -v tmux >/dev/null && tmux info >/dev/null 2>&1; then
    tmux source-file "$HOME/.tmux.conf"
    echo "reloaded running tmux server."
fi
