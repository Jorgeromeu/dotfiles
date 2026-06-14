# dotfiles

My configs across machines. Designed to be partially installable.

## Layout

Flat list of folders, one per tool (e.g `zsh`, `tmux`, ...) each holding that tools configs / installation scripts. The root level `./dot.sh` CLI entrypoint gives cenralized access to each modules commands:

```
./dot.sh help
```

## Philosophy

Module install scripts should set things up by **symlinking** config files into `$HOME` (via `lib.sh`'s `link` helper) — never by copying. That way `git pull` is the only thing needed to pick up the latest config on any host; nothing has to be re-run.

For settings that genuinely need to differ between hosts (accent colors, machine-specific paths, etc.), the tracked config sources an untracked local file if present. Example — `tmux/main.tmux` ends with:

```tmux
set -g @active_window_color "blue"        # default
source-file -q ~/.tmux.local.conf         # per-host override, if any
```

Each host's `~/.tmux.local.conf` stays local, never enters the repo, and a `setcolor` command writes it: `./dot.sh tmux setcolor red`. Apply the same pattern to any module that grows host-specific knobs.

## Creating a new module

A module is a folder containing:

- **Config files** — tomls, `.conf`, `.sh`, whatever the tool reads.
- **`commands/`** — a directory of executable `*.sh` scripts, each auto-exposed as `./dot.sh <module> <name>`. Add a `# desc: …` line to show up in `./dot.sh help`. `install.sh` is the conventional setup command and is what `./dot.sh all` runs.
- **`tools.txt`** — manifest of binaries this module benefits from, one per line as `<tool>  <description>`. Aggregated by `./dot.sh tools`.
