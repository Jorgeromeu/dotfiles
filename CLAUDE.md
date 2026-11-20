# Agent instructions

This repo is my dotfiles. **Read `README.md` first**: it defines the module
model (`module.toml`, `commands/`) and the conventions. Don't duplicate it here.

## When changing things

- Edit files in this repo, never in `$HOME` (`$HOME` only holds symlinks into
  this repo). If `status` shows `!` for a destination, `./dot.sh link <module>`
  backs up what's there and links.
- Prefer clean over backwards compatibility: rename/remove freely and update every
  reference (README, CLAUDE.md, configs, scripts) instead of keeping aliases.
- Keep it lean: use the program's own config options before writing shell code,
  and don't add features that weren't asked for.
- New program → new module. Add its links and deps to its `module.toml`; keep
  dep descriptions self-contained (what it is + how this config uses it).
- A config that starts using a program must guard it (`command -v`) and list it
  in `[deps]`; remove deps the config no longer uses.
- `starship/starship.toml` and `starship/starship-verbose.toml` share most
  sections: change shared ones in both.
- Update `README.md` when a convention or a module's purpose changes.

## Verifying

- `./dot.sh status` parses every `module.toml` and shows link/dep state.
- Test `link`/`unlink` against a throwaway home: `HOME=$(mktemp -d) ./dot.sh link`.
- zsh: `zsh -n zsh/zshrc.zsh`, then `zsh -ic 'echo ok'`.
- starship: `STARSHIP_CONFIG=starship/<file>.toml starship prompt` renders without
  warnings.
- `dot.sh` runs with `set -eu`: don't end a function with `test && action`
  (a false test aborts the script silently); use `if`.
- This host's git is old (2.25): avoid newer flags like `--path-format`.

## Commits

Only when asked. Message style: `<module>: <what changed>` (or `dot:` for the
CLI and docs), e.g. `starship: verbose git info on the right`.
