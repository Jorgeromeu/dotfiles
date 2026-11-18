#!/usr/bin/env bash
# desc: print the manual steps to link pacman.conf (needs root)
# skip-in-link-all: needs root
set -eu
HERE="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
MOD_DIR="$(cd "$HERE/.." && pwd)"

cat <<EOF
pacman config can't be linked unattended (it lives at /etc/pacman.conf and
needs root). To link it manually:

  sudo mv /etc/pacman.conf /etc/pacman.conf.bak
  sudo ln -s $MOD_DIR/pacman.conf /etc/pacman.conf

To revert:

  sudo rm /etc/pacman.conf
  sudo mv /etc/pacman.conf.bak /etc/pacman.conf
EOF
