#!/usr/bin/env bash
# Central dispatcher for dotfiles. Modules are subdirectories containing
# an executable install.sh (and optionally other executable *.sh scripts,
# each of which becomes a subcommand of that module).
#
# Usage:
#   ./dot.sh <module> <subcommand> [args...]
#   ./dot.sh <top-level-command> [args...]
set -eu

DOT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"

# Modules to skip when running `all` because they need extra input.
SKIP_IN_ALL=(nvim pacman)

# ---------- discovery ----------

list_modules() {
    local f
    for f in "$DOT_ROOT"/*/commands/*.sh; do
        [ -x "$f" ] || continue
        basename "$(dirname "$(dirname "$f")")"
    done | sort -u
}

# a directory is a module iff it contains a commands/ dir with at least one
# executable *.sh inside.
is_module() {
    local mod="$1" f
    [ -d "$DOT_ROOT/$mod/commands" ] || return 1
    for f in "$DOT_ROOT/$mod/commands"/*.sh; do
        [ -x "$f" ] && return 0
    done
    return 1
}

# echo subcommand names for a module (executable *.sh files in commands/, sans extension)
list_subcommands() {
    local mod="$1" f name
    for f in "$DOT_ROOT/$mod/commands"/*.sh; do
        [ -x "$f" ] || continue
        name="$(basename "$f" .sh)"
        echo "$name"
    done | sort
}

# read the first `# desc: ...` line of a script (skipping the shebang)
script_desc() {
    awk '
        NR == 1 && /^#!/ { next }
        /^# desc:/ { sub(/^# desc:[[:space:]]*/, ""); print; exit }
        /^[^#[:space:]]/ { exit }
    ' "$1"
}

in_array() {
    local needle="$1"; shift
    local item
    for item in "$@"; do
        [ "$item" = "$needle" ] && return 0
    done
    return 1
}

print_subcommands() {
    local mod="$1" indent="$2" sub desc f
    for sub in $(list_subcommands "$mod"); do
        f="$DOT_ROOT/$mod/commands/$sub.sh"
        desc="$(script_desc "$f")"
        if [ -n "$desc" ]; then
            printf '%s%-14s %s\n' "$indent" "$sub" "$desc"
        else
            printf '%s%s\n' "$indent" "$sub"
        fi
    done
}

# ---------- top-level commands ----------

cmd_help() {
    cat <<EOF
usage: ./dot.sh <module> <subcommand> [args...]
       ./dot.sh <top-level-command> [args...]

top-level commands:
  list                  list available modules
  all                   install every module that doesn't need extra input
  tools [--missing]     show recommended tools and which are installed
  help                  show this help

modules:
EOF
    local mod
    for mod in $(list_modules); do
        echo "  $mod"
        print_subcommands "$mod" "    "
    done
}

cmd_list() {
    list_modules
}

cmd_all() {
    local m
    for m in $(list_modules); do
        if in_array "$m" "${SKIP_IN_ALL[@]}"; then
            echo "skipped $m  (needs extra input — run: ./dot.sh $m install)"
            continue
        fi
        if [ ! -x "$DOT_ROOT/$m/commands/install.sh" ]; then
            echo "skipped $m  (no install.sh)"
            continue
        fi
        echo
        echo "=== $m install ==="
        "$DOT_ROOT/$m/commands/install.sh"
    done
}

cmd_tools() {
    local only_missing=false
    case "${1:-}" in
        --missing|missing) only_missing=true ;;
    esac

    local mod manifest line tool desc mark printed_header
    for mod in $(list_modules); do
        manifest="$DOT_ROOT/$mod/tools.txt"
        [ -f "$manifest" ] || continue
        printed_header=false
        while IFS= read -r line || [ -n "$line" ]; do
            case "$line" in
                ''|\#*) continue ;;
            esac
            read -r tool desc <<< "$line"
            [ -z "$tool" ] && continue

            if command -v "$tool" >/dev/null 2>&1; then
                mark="[x]"
                $only_missing && continue
            else
                mark="[ ]"
            fi

            if ! $printed_header; then
                echo "[$mod]"
                printed_header=true
            fi
            printf '  %s %-12s %s\n' "$mark" "$tool" "$desc"
        done < "$manifest"
        $printed_header && echo
    done
}

# ---------- module dispatch ----------

run_module() {
    local mod="$1"; shift
    if [ "$#" -eq 0 ]; then
        echo "usage: ./dot.sh $mod <subcommand> [args...]"
        echo
        echo "subcommands:"
        print_subcommands "$mod" "  "
        return 0
    fi
    local sub="$1"; shift
    local script="$DOT_ROOT/$mod/commands/$sub.sh"
    if [ ! -x "$script" ]; then
        echo "no such subcommand: $mod $sub" >&2
        echo >&2
        echo "available subcommands for $mod:" >&2
        print_subcommands "$mod" "  " >&2
        exit 1
    fi
    "$script" "$@"
}

# ---------- dispatch ----------

cmd="${1:-help}"
[ "$#" -gt 0 ] && shift

case "$cmd" in
    -h|--help|help) cmd_help ;;
    list)           cmd_list "$@" ;;
    all)            cmd_all "$@" ;;
    tools)          cmd_tools "$@" ;;
    *)
        if is_module "$cmd"; then
            run_module "$cmd" "$@"
        else
            echo "unknown command/module: $cmd" >&2
            echo >&2
            cmd_help >&2
            exit 1
        fi
        ;;
esac
