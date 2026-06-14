# Shared helpers for install scripts. Source from each module's install.sh:
#   source "$(dirname "${BASH_SOURCE[0]:-$0}")/../lib.sh"

# link <src> <dest>
# - if dest is already a correct symlink: no-op
# - if dest is a different symlink: replace
# - if dest is a real file/dir: back up to dest.bak.<timestamp> then link
link() {
    local src="$1" dest="$2"
    mkdir -p "$(dirname "$dest")"
    if [ -L "$dest" ]; then
        if [ "$(readlink "$dest")" = "$src" ]; then
            echo "  $dest already linked"
            return
        fi
        rm "$dest"
    elif [ -e "$dest" ]; then
        mv "$dest" "$dest.bak.$(date +%s)"
        echo "  backed up existing $dest"
    fi
    ln -s "$src" "$dest"
    echo "  $dest -> $src"
}
