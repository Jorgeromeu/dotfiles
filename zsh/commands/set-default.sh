#!/usr/bin/env bash
# desc: try to set zsh as the login shell (falls back to printing manual steps)
set -eu

zsh_path="$(command -v zsh || true)"
if [ -z "$zsh_path" ]; then
    echo "zsh is not installed. Install it first, then re-run this script."
    exit 1
fi

current="$(getent passwd "$USER" 2>/dev/null | cut -d: -f7 || true)"
current="${current:-$SHELL}"

if [ "$current" = "$zsh_path" ]; then
    echo "zsh is already your login shell ($zsh_path)."
    exit 0
fi

echo "current login shell: $current"
echo "target login shell:  $zsh_path"
echo

in_shells=false
if grep -qx "$zsh_path" /etc/shells 2>/dev/null; then
    in_shells=true
fi

if $in_shells && chsh -s "$zsh_path" 2>/dev/null; then
    echo "switched login shell to $zsh_path. Log out and back in to take effect."
    exit 0
fi

echo "couldn't switch automatically. Run these manually:"
$in_shells || echo "  sudo sh -c 'echo $zsh_path >> /etc/shells'"
echo "  chsh -s $zsh_path"
