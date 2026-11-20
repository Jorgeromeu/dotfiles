#!/usr/bin/env bash
# dot.sh: link this repo's configs into place. See README.md for the model,
# and usage() below for the commands.
set -eu

DOT_ROOT="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"

# Colors, only when stdout is a terminal and NO_COLOR isn't set.
if [ -t 1 ] && [ -z "${NO_COLOR:-}" ]; then
    BOLD=$'\e[1m' DIM=$'\e[2m' RED=$'\e[31m' GREEN=$'\e[32m' YELLOW=$'\e[33m' BLUE=$'\e[34m' RESET=$'\e[0m'
else
    BOLD='' DIM='' RED='' GREEN='' YELLOW='' BLUE='' RESET=''
fi

die() { echo "${RED}$*${RESET}" >&2; exit 1; }

# ---------- module.toml ----------
# A strict TOML subset: comments, a top-level `description`, and [links] /
# [deps] sections of `key = "value"` lines (keys may be quoted).

RE_BLANK='^[[:space:]]*(#.*)?$'
RE_SECTION='^[[:space:]]*\[([a-z]+)\][[:space:]]*(#.*)?$'
RE_PAIR='^[[:space:]]*("[^"]*"|[A-Za-z0-9_.+-]+)[[:space:]]*=[[:space:]]*"([^"]*)"[[:space:]]*(#.*)?$'

# toml_section <file> <section>: print "key<TAB>value" for each pair in the
# section ("" = top level). Fails on anything outside the subset.
toml_section() {
    local file="$1" want="$2" section="" line key n=0
    while IFS= read -r line || [ -n "$line" ]; do
        n=$((n + 1))
        if [[ $line =~ $RE_BLANK ]]; then
            continue
        elif [[ $line =~ $RE_SECTION ]]; then
            section="${BASH_REMATCH[1]}"
            case "$section" in links|deps) ;; *) die "$file:$n: unknown section [$section]" ;; esac
        elif [[ $line =~ $RE_PAIR ]]; then
            key="${BASH_REMATCH[1]}"; key="${key#\"}"; key="${key%\"}"
            if [ -z "$section" ] && [ "$key" != description ]; then
                die "$file:$n: unknown top-level key '$key'"
            fi
            [ "$section" = "$want" ] && printf '%s\t%s\n' "$key" "${BASH_REMATCH[2]}"
        else
            die "$file:$n: not in the supported TOML subset: $line"
        fi
    done < "$file"
    return 0
}

modules() {
    local f
    for f in "$DOT_ROOT"/*/module.toml; do
        if [ -e "$f" ]; then basename "$(dirname "$f")"; fi
    done
}

is_module() { [ -f "$DOT_ROOT/$1/module.toml" ]; }

# select_modules [module...]: set MODS to the given modules (none = all),
# after checking each exists and its module.toml parses.
select_modules() {
    if [ "$#" -eq 0 ]; then mapfile -t MODS < <(modules); else MODS=("$@"); fi
    local m
    for m in "${MODS[@]}"; do
        is_module "$m" || die "unknown module: $m"
        toml_section "$DOT_ROOT/$m/module.toml" "" >/dev/null
    done
}

# links <module>: print "dest<TAB>src" with dest expanded and src absolute.
links() {
    local dest src
    toml_section "$DOT_ROOT/$1/module.toml" links | while IFS=$'\t' read -r dest src; do
        printf '%s\t%s\n' "${dest/#\~/$HOME}" "$DOT_ROOT/$1/$src"
    done
}

# Paths outside $HOME need root: we print the commands instead of running them.
is_system() { [[ $1 != "$HOME"/* ]]; }

# link_state <dest> <src>: ok | missing | other (real file, or link elsewhere)
link_state() {
    if [ -L "$1" ] && [ "$(readlink "$1")" = "$2" ]; then echo ok
    elif [ -e "$1" ] || [ -L "$1" ]; then echo other
    else echo missing
    fi
}

tilde() { echo "${1/#$HOME/\~}"; }

# needs_root <dest> <command...>: print the sudo commands a system path needs.
needs_root() {
    echo "  ${YELLOW}– $1 needs root, run:${RESET}"
    shift
    printf '      sudo %s\n' "$@"
}

# ---------- link / unlink ----------

link_one() {
    local dest="$1" src="$2"
    [ -e "$src" ] || die "missing source: $src"
    if [ "$(link_state "$dest" "$src")" = ok ]; then
        echo "  ${DIM}✓ $(tilde "$dest")${RESET}"
        return 0
    fi
    local backup=""
    if [ -e "$dest" ] && ! [ -L "$dest" ]; then backup="$dest.bak.$(date +%s)"; fi
    if is_system "$dest"; then
        if [ -n "$backup" ]; then needs_root "$dest" "mv $dest $backup" "ln -sfn $src $dest"
        else needs_root "$dest" "ln -sfn $src $dest"; fi
        return 0
    fi
    mkdir -p "$(dirname "$dest")"
    if [ -n "$backup" ]; then
        mv "$dest" "$backup"
        echo "  ${YELLOW}backed up $(tilde "$dest")${RESET}"
    fi
    ln -sfn "$src" "$dest"
    echo "  ${GREEN}✓ $(tilde "$dest")${RESET} -> $(tilde "$src")"
}

unlink_one() {
    local dest="$1" backup
    if ! [ -L "$dest" ] || [[ $(readlink "$dest") != "$DOT_ROOT"/* ]]; then
        if [ -e "$dest" ] || [ -L "$dest" ]; then
            echo "  ${YELLOW}! $(tilde "$dest") isn't our link, left alone${RESET}"
        else
            echo "  ${DIM}✗ $(tilde "$dest") not linked${RESET}"
        fi
        return 0
    fi
    backup="$(ls -1d "$dest".bak.* 2>/dev/null | sort | tail -n 1)"
    if is_system "$dest"; then
        if [ -n "$backup" ]; then needs_root "$dest" "rm $dest" "mv $backup $dest"
        else needs_root "$dest" "rm $dest"; fi
        return 0
    fi
    rm "$dest"
    echo "  ${GREEN}✗ $(tilde "$dest") unlinked${RESET}"
    if [ -n "$backup" ]; then
        mv "$backup" "$dest"
        echo "  ${GREEN}restored $(tilde "$backup")${RESET}"
    fi
}

cmd_link_or_unlink() {
    local action="$1" m dest src; shift
    select_modules "$@"
    for m in "${MODS[@]}"; do
        echo "${BOLD}${BLUE}$m${RESET}"
        while IFS=$'\t' read -r dest src; do
            "${action}_one" "$dest" "$src"
        done < <(links "$m")
    done
}

# ---------- status / help ----------

# module_commands <module>: print "name<TAB>desc" for each commands/*.sh
module_commands() {
    local f desc
    for f in "$DOT_ROOT/$1"/commands/*.sh; do
        [ -x "$f" ] || continue
        desc="$(sed -n 's/^# desc:[[:space:]]*//p' "$f" | head -n 1)"
        printf '%s\t%s\n' "$(basename "$f" .sh)" "$desc"
    done
}

cmd_status() {
    local m dest src state desc dep deps name
    select_modules "$@"
    for m in "${MODS[@]}"; do
        desc="$(toml_section "$DOT_ROOT/$m/module.toml" "" | cut -f2)"
        printf '%s%-10s%s %s\n' "$BOLD$BLUE" "$m" "$RESET" "$desc"

        while IFS=$'\t' read -r dest src; do
            state="$(link_state "$dest" "$src")"
            case "$state" in
                ok)      echo "  ${GREEN}✓${RESET} $(tilde "$dest")" ;;
                missing) if is_system "$dest"; then echo "  ${YELLOW}–${RESET} $dest ${DIM}(system path, needs root)${RESET}"
                         else echo "  ${RED}✗${RESET} $(tilde "$dest") ${DIM}(not linked)${RESET}"; fi ;;
                other)   echo "  ${YELLOW}!${RESET} $(tilde "$dest") ${DIM}(something else is there; link backs it up)${RESET}" ;;
            esac
        done < <(links "$m")

        deps=""
        while IFS=$'\t' read -r dep _; do
            if command -v "$dep" >/dev/null 2>&1; then deps+=" ${GREEN}✓${RESET} $dep"
            else deps+=" ${RED}✗${RESET} $dep"; fi
        done < <(toml_section "$DOT_ROOT/$m/module.toml" deps)
        if [ -n "$deps" ]; then echo "  ${DIM}deps${RESET}    $deps"; fi

        while IFS=$'\t' read -r name desc; do
            echo "  ${DIM}command${RESET}  ./dot.sh $m ${GREEN}$name${RESET}  ${DIM}$desc${RESET}"
        done < <(module_commands "$m")
        echo
    done
}

usage() {
    cat <<EOF
Usage:
  ./dot.sh [status] [module...]   links, deps and commands of each module
  ./dot.sh link     [module...]   symlink configs into place (default: all)
  ./dot.sh unlink   [module...]   remove those symlinks, restore backups (default: all)
  ./dot.sh <module> [command]     run a module's command (none: its status)
  ./dot.sh help

Modules: $(modules | paste -sd ' ')
EOF
}

run_command() {
    local m="$1"; shift
    if [ "$#" -eq 0 ]; then cmd_status "$m"; return; fi
    local script="$DOT_ROOT/$m/commands/$1.sh"; shift
    [ -x "$script" ] || die "no such command for $m (see: ./dot.sh status $m)"
    DOT_ROOT="$DOT_ROOT" MOD_DIR="$DOT_ROOT/$m" "$script" "$@"
}

# ---------- dispatch ----------

cmd="${1:-status}"
if [ "$#" -gt 0 ]; then shift; fi
case "$cmd" in
    status)          cmd_status "$@" ;;
    link|unlink)     cmd_link_or_unlink "$cmd" "$@" ;;
    help|-h|--help)  usage ;;
    *)               is_module "$cmd" || { usage >&2; die "unknown command or module: $cmd"; }
                     run_command "$cmd" "$@" ;;
esac
