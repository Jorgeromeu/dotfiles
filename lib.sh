# Shared helpers for module commands. Source from each module's commands/*.sh:
#   source "$(dirname "${BASH_SOURCE[0]:-$0}")/../lib.sh"

# Colors, only when stdout is a terminal and NO_COLOR isn't set.
if [ -t 1 ] && [ -z "${NO_COLOR:-}" ]; then
    BOLD=$'\e[1m' DIM=$'\e[2m' RED=$'\e[31m' GREEN=$'\e[32m' YELLOW=$'\e[33m' BLUE=$'\e[34m' RESET=$'\e[0m'
else
    BOLD='' DIM='' RED='' GREEN='' YELLOW='' BLUE='' RESET=''
fi

# link <src> <dest>
# - if dest is already a correct symlink: no-op
# - if dest is a different symlink: replace
# - if dest is a real file/dir: back up to dest.bak.<timestamp> then link
link() {
    local src="$1" dest="$2"
    mkdir -p "$(dirname "$dest")"
    if [ -L "$dest" ]; then
        if [ "$(readlink "$dest")" = "$src" ]; then
            echo "  ${DIM}$dest already linked${RESET}"
            return
        fi
        rm "$dest"
    elif [ -e "$dest" ]; then
        mv "$dest" "$dest.bak.$(date +%s)"
        echo "  ${YELLOW}backed up existing $dest${RESET}"
    fi
    ln -s "$src" "$dest"
    echo "  ${GREEN}$dest${RESET} -> $src"
}
