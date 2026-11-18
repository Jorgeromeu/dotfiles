# Agent instructions

This repo is my dotfiles. **Read `README.md` first**: its Conventions section is
the source of truth for how everything is organised. Don't duplicate it here.

## When changing a config

- Edit the file in this repo, never a copy in `$HOME` (`$HOME` should only hold
  symlinks into this repo). If `$HOME` has a real file where a link should be,
  run `./dot.sh <module> link` (it backs the file up and links).
- Prefer clean over backwards compatibility: rename/remove freely and update
  every reference (README, CLAUDE.md, scripts) instead of keeping aliases.
- Keep it lean: use the tool's own config options before writing shell code,
  and don't add features that weren't asked for.
- A new tool gets its own module (see README → Adding a module), not a corner
  of another module's config.
- Guard any tool a config uses with `command -v`, and list it in that module's
  `tools.txt`. Remove `tools.txt` entries the config no longer references.
- `starship/starship.toml` and `starship/starship-verbose.toml` share most
  sections: change shared ones in both.
- Update `README.md` when a convention or a module's purpose changes.

## Verifying

- zsh: `zsh -n zsh/zshrc.zsh` (syntax), then `zsh -ic 'echo ok'` (loads cleanly).
- starship: `STARSHIP_CONFIG=starship/<file>.toml starship prompt` renders
  without warnings; `starship timings` for slow modules.
- link scripts: `./dot.sh <module> link` is idempotent; run it twice.
- Note the host's git is old (2.25): avoid newer flags like `--path-format`.

## Commits

Only when asked. Message style: `<module>: <what changed>`, e.g.
`starship: verbose git info on the right`.
