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

- **Shell** — `.bashrc`, `.bash_profile` (exports `SSH_AUTH_SOCK` for
  [KeeAgent](https://gist.github.com/strarsis/e533f4bca5ae158481bbe53185848d49),
  KeePass2's SSH agent — KeePass2 + KeeAgent must be running)
- **Git** — `.gitconfig`, global gitignore/gitattributes, commit message
  template
  - `pull.rebase = merges` to avoid merge commits on pull
  - `commit.template` points at `.gitmessage.txt`, a Conventional Commits
    template
  - `diff=excel`/`merge=excel` attributes for `.xls*` (plus `diff=msword` for
    Word, `diff=astextplain` for PDF); `diff.excel.command` points at
    `$env:LOCALAPPDATA\Microsoft\WindowsApps\xldiff.bat`.
    It wraps Microsoft's SpreadsheetCompare (via `AppVLP.exe` when present).
- **Editor** — `.editorconfig`
- **ctags** — `.ctags.d/*.ctags` (Universal Ctags reads this directory, not
  `~/.ctags`); `windows_home.ctags` and `exclude.ctags` add excludes (e.g.
  `AppData`, `OneDrive`, `.venv`, `.jupyter`, `node_modules`) so
  `ctags -R %USERPROFILE%` stays usable on Windows
- **Python / Jupyter** — IPython profile and startup scripts,
  Jupyter notebook/lab/server config
- **Claude Code** — default `CLAUDE.md` project config
- **WSL** — `.wslconfig`
- **uv** — global `uv.toml`

## License

MIT — see [LICENSE.txt](LICENSE.txt).
