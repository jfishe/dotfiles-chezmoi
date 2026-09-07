# dotfiles-chezmoi

Personal dotfiles, managed with [chezmoi](https://www.chezmoi.io/).

## Install

```sh
chezmoi init --apply jfishe/dotfiles-chezmoi
```

To pull down and apply later changes:

```sh
chezmoi update
```

Or review changes before applying:

```sh
chezmoi diff
chezmoi apply
```

`README.md` and `LICENSE.txt` are excluded from application via
`.chezmoiignore` — they document this repo, not files to place in `$HOME`.

## What's managed

- **Shell** — `.bashrc` (vi mode, `EDITOR=vim`), `.bash_profile` (exports
  `SSH_AUTH_SOCK` for
  [KeeAgent](https://gist.github.com/strarsis/e533f4bca5ae158481bbe53185848d49),
  KeePass2's SSH agent — KeePass2 + KeeAgent must be running)
- **Git** — `.gitconfig`, global gitignore/gitattributes, commit message
  template
  - `pull.rebase = merges` to avoid merge commits on pull
  - `delta` as pager and interactive diff filter
  - `commit.template` points at `.gitmessage.txt`, a Conventional Commits
    template
  - `diff=excel`/`merge=excel` attributes for `.xls*` (plus `diff=msword` for
    Word, `diff=astextplain` for PDF); `diff.excel.command` runs
    `xldiff.bat` (installed under `AppData\Local\Microsoft\WindowsApps`,
    which is on `PATH` by default on Windows). It wraps Microsoft's
    SpreadsheetCompare (via `AppVLP.exe` when present).
  - `rerere` enabled/autoupdate, `diff3` conflict style, `vimdiff` as
    diff/merge tool
  - `[include]` pulls in an untracked, installation-specific
    `~/.dotfiles/.gitconfig` (e.g. for a credential helper)
- **Editor** — `.editorconfig`
- **Terminal** — [starship](https://starship.rs) prompt config
  (`follow_symlinks = false`); mintty (Git Bash terminal) config with
  bundled Solarized Dark/Light themes
- **ctags** — `ctags.d/default.ctags`. On Windows, Universal Ctags (v6.1+)
  reads config from `%HOMEDRIVE%%HOMEPATH%\ctags.d\*.ctags` — a separate
  location from the XDG `ctags/*.ctags` config Jupyter/Python tooling uses —
  so `ctags -R %USERPROFILE%` stays usable. Excludes (e.g. `AppData`,
  `OneDrive`, `.venv`, `Modules`, `node_modules`) are kept in the same file
  as `--recurse`, in a single well-commented list, since exclude order
  relative to `--recurse` matters and splitting them across files made that
  order depend on fragile alphabetical load order.
- **Python / Jupyter** — IPython profile and startup scripts,
  Jupyter notebook/lab/server config
- **Claude Code** — default `CLAUDE.md` project config (uv-based Python
  project rules: package management, testing, linting, type checking)
- **WSL** — `.wslconfig` (mirrored networking, GUI app support)
- **uv** — global `uv.toml` (`exclude-newer = "7 days"`, to avoid pulling in
  packages published very recently)

## License

MIT — see [LICENSE.txt](LICENSE.txt).
