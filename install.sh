#!/usr/bin/env bash
# Bootstrap a machine from this repo. Safe to run again.
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"

# Homebrew: install if missing, then put it on PATH (Apple Silicon or Linux).
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
for brew_bin in /opt/homebrew/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
  if [ -x "$brew_bin" ]; then eval "$("$brew_bin" shellenv)"; fi
done

# Tools. ~/Brewfile.local holds employer tools and is optional.
brew bundle --file=Brewfile
if [ -f ~/Brewfile.local ]; then brew bundle --file="$HOME/Brewfile.local"; fi

# Config files. Stow stops and names the file if a real one is in the way.
stow --no-folding -t ~ git zsh cmux nvim mise

# Runtimes listed in the mise config.
mise install

# Only take over ~/.zshrc when nobody else owns it.
if [ -L ~/.zshrc ] || [ ! -e ~/.zshrc ]; then
  stow --no-folding -t ~ zsh-base
else
  echo "Existing ~/.zshrc left alone. Add to it: source ~/.config/zsh/personal.zsh"
fi

echo "Done. Restart the terminal, then see README.md for the manual steps."
