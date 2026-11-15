# dotfiles

My development environment: the tools and config I carry between machines and employers.
macOS first; Linux is in progress.

## Install

```bash
git clone https://github.com/kerolloz/dotfiles.git ~/dotfiles && cd ~/dotfiles && ./install.sh
```

`install.sh` is safe to run again. It:

1. Installs Homebrew if missing, then everything in the [Brewfile](./Brewfile).
2. Links the config packages into `$HOME` with [GNU Stow](https://www.gnu.org/software/stow/).
   If a real file is in the way, Stow stops and names it; move it aside and run again.
3. Installs the runtimes listed in the mise config (Node, Bun, Go).

Then, by hand:

1. Restart the terminal. The first shell installs Oh My Zsh and Powerlevel10k.
2. Run `gh auth login`.
3. Sign in to GitHub in VS Code so Settings Sync brings the editor settings.
4. On a work machine, write the untracked files listed below.

## Layout

Each top-level folder is a Stow package that mirrors `$HOME`.

| Package | Links to | What it is |
| --- | --- | --- |
| `zsh` | `~/.config/zsh/personal.zsh`, `~/.p10k.zsh` | Oh My Zsh, Powerlevel10k, aliases, mise activation |
| `zsh-base` | `~/.zshrc` | Minimal base, linked only when no `~/.zshrc` exists |
| `git` | `~/.gitconfig` | Personal identity; includes the machine-local file |
| `cmux` | `~/.config/cmux/cmux.json`, `~/.config/ghostty/config` | cmux shortcuts and settings, plus the Ghostty-format file cmux reads for fonts, theme and terminal keys |
| `nvim` | `~/.config/nvim/` | LazyVim |
| `mise` | `~/.config/mise/conf.d/personal.toml` | Node, Bun and Go versions, beside any employer `config.toml` |

## What is not in here

Anything that belongs to an employer or a single machine lives in untracked files that the
tracked ones include when present. Changing jobs should not need a commit in this repo.

| File                             | Holds                                                        |
| -------------------------------- | ------------------------------------------------------------ |
| `~/.config/git/local.gitconfig`  | `includeIf` rules for work remotes, hooks, employer settings |
| `~/.config/git/<work>.gitconfig` | Work name, email and credential helper                       |
| `~/.zshrc.local`                 | Work PATHs and environment (sourced by `zsh-base/.zshrc`)    |
| `~/Brewfile.local`               | Employer tools, applied by `install.sh` if present           |

Example `~/.config/git/local.gitconfig`:

```ini
[includeIf "hasconfig:remote.*.url:https://github.com/<work-org>/**"]
    path = ~/.config/git/<work>.gitconfig
[includeIf "hasconfig:remote.*.url:git@github.com:<work-org>/**"]
    path = ~/.config/git/<work>.gitconfig
```

If an employer manages `~/.zshrc`, leave theirs in place and add one line to it or to the
personal hook it provides:

```sh
source ~/.config/zsh/personal.zsh
```

## History

This repo started in 2018 as Installify, a set of apt scripts for a new Linux install.
Those scripts are at the [`legacy-apt`](../../tree/legacy-apt) tag.
