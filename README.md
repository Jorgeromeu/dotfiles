# dotfiles

My configs across machines. Designed to be partially installable: each module
works on its own, and every config degrades gracefully when a tool is missing.

```sh
./dot.sh help              # modules and their commands
./dot.sh <module> link     # symlink one module's config into place
./dot.sh link-all          # link every module (except ones needing input)
./dot.sh tools [--missing] # which tools each module uses, and which are installed
```

## Layout

Flat list of folders, one per tool (`zsh`, `tmux`, `starship`, ...). A module is a folder containing:

- **Config files**: whatever the tool reads (`.toml`, `.conf`, `.zsh`, ...).
- **`commands/`**: executable `*.sh` scripts, each exposed as `./dot.sh <module> <name>`.
  A `# desc: …` line (after the shebang) shows it in `./dot.sh help`.
  Every module has `link.sh`, which only symlinks its configs into place (and is what
  `./dot.sh link-all` runs). Anything with other side effects is its own command,
  e.g. `./dot.sh zsh set-default` or `./dot.sh tmux setcolor red`.
  A `link.sh` that needs input or root adds a `# skip-in-link-all: <reason>` line.
- **`tools.txt`**: the programs this module's config uses, one per line as `<tool>  <description>`.

## Conventions

1. **Symlink, never copy.** `link.sh` links config files into `$HOME` with
   `lib.sh`'s `link` helper (idempotent; backs up a real file it would replace).
   `git pull` is then all a host needs to pick up changes.
2. **One tool, one module.** A tool's config lives in its own module, linked to
   the tool's standard location (e.g. `~/.config/starship.toml`). Another module
   only adds the glue it must own, like the zshrc running `starship init zsh`.
3. **Guard optional tools.** Configs check before using a tool
   (`command -v foo >/dev/null && ...`) and fall back or do nothing without it,
   so any config can be sourced on any host.
4. **`tools.txt` is informational.** Nothing installs from it and nothing reads it
   except `./dot.sh tools`. List only tools the module's config actually references.
5. **Per-host settings go in an untracked local file** that the tracked config sources
   if present. Example: `tmux/main.tmux` ends with

   ```tmux
   set -g @active_window_color "blue"        # default
   source-file -q ~/.tmux.local.conf         # per-host override, if any
   ```

   and `./dot.sh tmux setcolor red` writes that file. Use the same pattern for any
   module that grows host-specific knobs.
6. **Prefer the tool's own config over custom shell code.** Small, idiomatic,
   commented configs; no clever glue that breaks silently on upgrades.

## Modules of note

- **zsh**: `zshrc.zsh` (linked to `~/.zshrc`) and `aliases.sh`.
- **starship**: the prompt. `starship.toml` is the minimal prompt and
  `starship-verbose.toml` the verbose one; in zsh, Alt-i switches between them by
  setting `STARSHIP_CONFIG`. Starship configs can't include each other, so the
  verbose file is a full copy: keep the shared sections in sync. Without starship,
  zsh falls back to a plain built-in prompt.
- **tmux**: `main.tmux`, with per-host colors via `setcolor`.

## Adding a module

1. `mkdir -p foo/commands`, add the config files.
2. Add `foo/commands/link.sh` (copy an existing one: it sources `lib.sh` and calls
   `link`), and `chmod +x` it.
3. Add `foo/tools.txt`.
4. Run `./dot.sh foo link` and check `./dot.sh help` lists it.
