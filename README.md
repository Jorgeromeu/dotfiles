# dotfiles

My configs across machines. Clone anywhere, then symlink what you want:

```sh
./dot.sh                      # status: every module's links, deps and commands
./dot.sh link   [module...]   # symlink configs into place (no args = all)
./dot.sh unlink [module...]   # remove those symlinks, restore any backups (no args = all)
./dot.sh <module> [command]   # module-specific extras, e.g. ./dot.sh tmux setcolor red
                              # (no command: that module's status)
./dot.sh help
```

The repo only stores configs. It never installs programs: each module lists the
programs it uses as `deps`, and `status` shows which are missing.

## Modules

A module is a folder with a `module.toml`, one per program:

```
tmux/
  module.toml        description, [links], [deps]
  main.tmux          config files: anything the program reads
  commands/          optional extras, one script per command
    setcolor.sh
```

### `module.toml`

```toml
description = "tmux: keybindings, status bar, per-host accent color"

[links]                        # destination = file in this module
"~/.tmux.conf" = "main.tmux"

[deps]                         # program = what it is and how this config uses it
tmux = "terminal multiplexer"
```

- **`[links]`** is all `link`, `unlink` and `status` act on. Keys are destinations,
  so one file can go to several places (`nvim` links `init.vim` twice). A folder
  can be linked too. Files not listed (e.g. `zsh/aliases.sh`) aren't linked: the
  linked config loads them from the repo.
- **`[deps]`** is informational: `status` checks each with `command -v`. Describe
  what the program is *and* how this module's config uses it.
- `dot.sh` reads a strict TOML subset: comments, a top-level `description`,
  and `[links]` / `[deps]` sections of `key = "value"` lines (no `"` inside
  values). Anything else is an error that names the line.

### `commands/`

Each executable `commands/<name>.sh` is runnable as `./dot.sh <module> <name>`, and
describes itself with a `# desc: …` line (shown by `status`). Scripts get `DOT_ROOT`
and `MOD_DIR` in their environment. Existing ones:
`zsh set-default`, `tmux setcolor`, `nvim use`, `herdr reload`.

## Conventions

1. **Declare everything once.** Links and deps live in `module.toml`; a command's
   description lives in its script.
2. **`link` only creates symlinks.** Anything else (changing the login shell,
   reloading a program, writing a per-host file) is a named command.
3. **Clone anywhere.** Configs find their sibling files from their own resolved
   path, never from a hardcoded `~/dotfiles` (e.g. zshrc uses `${${(%):-%x}:A:h}`,
   vim uses `resolve(expand('<sfile>:p'))`). If you move the repo, run `link` again.
4. **Per-host settings go in an untracked local file** the config includes with the
   program's own mechanism: tmux sources `~/.tmux.local.conf` (written by
   `setcolor`), nvim reads its profile from `~/.config/nvim/profile` (written by
   `use`). Same pattern for git (`[include] path = ~/.gitconfig.local`) or ssh
   (`Include ~/.ssh/config.local`).
5. **Guard optional programs.** Configs check `command -v foo` before using `foo`
   and fall back or skip, so every config loads on every host.
6. **System paths need root.** A `[links]` destination outside `$HOME` (e.g.
   `/etc/pacman.conf`) is never touched: `link`/`unlink` print the `sudo` commands.
7. **Never store secrets or machine-written state**: keys, tokens (e.g. gh's
   `hosts.yml`), histories, `~/.claude/settings.local.json`. Link only the settings
   files of tools that mix both.
8. **Clean over backwards compatible.** Rename and remove freely; update every
   reference instead of keeping aliases.

Out of scope: Windows-side configs on WSL (Windows programs don't follow WSL symlinks).

## Notes per module

- **zsh**: `zshrc.zsh` plus `aliases.sh`. Uses starship for the prompt when
  installed, else a plain built-in prompt. `shorthost <name>` sets this
  machine's name in the minimal prompt over ssh (stored per machine in
  `~/.config/shorthost`, not in the repo).
- **starship**: minimal `starship.toml` and `starship-verbose.toml`; Alt-i in zsh
  toggles by setting `STARSHIP_CONFIG`. Starship configs can't include each other,
  so the verbose file is a full copy: keep shared sections in sync.
- **nvim**: `init.vim` loads the host's profile (`common.vim` by default,
  `minimal.vim` = common + a colorscheme). `obsidian.vimrc` isn't a profile: copy it
  into an Obsidian vault as `.obsidian.vimrc`.

## Adding a module

1. Create `foo/module.toml` and the config files next to it.
2. Optionally add `foo/commands/<name>.sh` (executable, with a `# desc:` line).
3. `./dot.sh link foo`, then check `./dot.sh status foo`.
