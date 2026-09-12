# Chezmoi Configuration Management (dotfiles)

Personal dotfiles, managed with [chezmoi].

## Installation

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

On first `chezmoi init`,
you'll be prompted once for a `profile` (`work`/`home`);
the answer is stored in the local, untracked
`~/.config/chezmoi/chezmoi.toml` and
used by templated files (e.g. `dot_wslconfig.tmpl`)
to vary content per machine.
To answer non-interactively:
`chezmoi init --promptString profile=home --apply`.

`README.md` and `LICENSE.txt` are excluded from application via
`.chezmoiignore` --- they document this repo, not files to place in `$HOME`.

## What's managed

- **Shell** --- `.bashrc` (vi mode, `EDITOR=vim`), `.bash_profile` (exports
  `SSH_AUTH_SOCK` for
  [KeeAgent],
  KeePass2's SSH agent --- KeePass2 + KeeAgent must be running)
- **Git** --- `.gitconfig`, global gitignore/gitattributes, commit message
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
- **Editor** --- `.editorconfig`
- **Terminal** --- [starship] prompt config
  (`follow_symlinks = false`); mintty (Git Bash terminal) config with
  bundled Solarized Dark/Light themes
- **ctags** --- `ctags.d/default.ctags`. On Windows, Universal Ctags (v6.1+)
  reads config from `%HOMEDRIVE%%HOMEPATH%\ctags.d\*.ctags` --- a separate
  location from the XDG `ctags/*.ctags` config Jupyter/Python tooling uses ---
  so `ctags -R %USERPROFILE%` stays usable. Excludes (e.g. `AppData`,
  `OneDrive`, `.venv`, `Modules`, `node_modules`) are kept in the same file
  as `--recurse`, in a single well-commented list, since exclude order
  relative to `--recurse` matters and splitting them across files made that
  order depend on fragile alphabetical load order.
- **Python / Jupyter** --- IPython profile and startup scripts,
  Jupyter notebook/lab/server config
- **Claude Code** --- default `CLAUDE.md` project config (uv-based Python
  project rules: package management, testing, linting, type checking)
- **WSL** --- `.wslconfig` (GUI app support everywhere; mirrored networking +
  loopback only on the `home` profile)
- **uv** --- global `uv.toml` (`exclude-newer = "7 days"`, to avoid pulling in
  packages published very recently)

## Windows Packages (winget)

`.chezmoidata/packages.yaml` lists [winget] package IDs,
installed via a `run_onchange_` script
`.chezmoiscripts/run_onchange_install-packages.ps1.tmpl`)
`chezmoi apply` keeps them in sync.
Installs use `--scope user` (no elevation)
unless a package overrides `scope`.
Already-installed packages are skipped.
Packages can be restricted to a profile via a `profiles: [...]` list;
omit it to install everywhere.
[Winget] "answer files" (silent-install config for packages like Git)
live as `.ini` files under `winget/`
(excluded from application via `.chezmoiignore`) and
are referenced by name from `packages.yaml`.
Editing `packages.yaml` re-triggers the install script
on the next `chezmoi apply`;
this is install-only and
never uninstalls a package removed from the list.

## Git for Windows

[Git for Windows silent or unattended installation]
allows changes from the default options,
supported by [winget].

[ElateralLtd git commit template] provides a template, which was updated
per [Conventional Commits].

### Pixi and conda-forge

[Pixi] supports [conda-forge] packages
without activating an environment,
like [Miniforge].

```powershell
# powershell -ExecutionPolicy Bypass
# Invoke-RestMethod -UseBasicParsing https://pixi.sh/install.ps1 | Invoke-Expression

pixi global install nodejs starship perl
```

## Vim Dependencies

[Vim configuration] depends on [junegunn fzf.vim].

- [fzf] a general-purpose command-line fuzzy finder and an interactive terminal toolkit
- [bat] for syntax-highlighted preview
- If [delta] is available, `GF?`, `Commits` and `BCommits` will use it to
  format `git diff` output.
- `Rg` requires [ripgrep (rg)]
- `Tags` and `Helptags` require Perl
- `Tags PREFIX` requires `readtags` command from [Universal Ctags]

[Conquer of Completion] does not depend on the python compiled with Vim but
does require `node.js`.

## License

MIT --- see [LICENSE.txt].

[chezmoi]: https://www.chezmoi.io/
[KeeAgent]: https://gist.github.com/strarsis/e533f4bca5ae158481bbe53185848d49
[starship]: https://starship.rs
[winget]: https://learn.microsoft.com/en-us/windows/package-manager/winget/
[Git for Windows silent or unattended installation]: https://gitforwindows.org/silent-or-unattended-installation.html
[ElateralLtd git commit template]: https://github.com/ElateralLtd/git-commit-template
[Conventional Commits]: https://www.conventionalcommits.org/en/v1.0.0/
[Pixi]: https://pixi.prefix.dev/latest/
[conda-forge]: https://conda-forge.org/
[Miniforge]: https://docs.conda.io/projects/conda
[Vim configuration]: https://github.com/jfishe/vimfiles
[junegunn fzf.vim]: https://github.com/junegunn/fzf.vim
[fzf]: https://github.com/junegunn/fzf
[bat]: https://github.com/sharkdp/bat
[delta]: https://github.com/dandavison/delta
[ripgrep (rg)]: https://github.com/BurntSushi/ripgrep
[Universal Ctags]: https://ctags.io/
[Conquer of Completion]: https://github.com/neoclide/coc.nvim
[LICENSE.txt]: LICENSE.txt
