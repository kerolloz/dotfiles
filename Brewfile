# Tools I install on day one on any machine.
# Employer-specific tools go in ~/Brewfile.local (untracked); install.sh applies it if present.

# Core
brew "git"
brew "gh"
brew "stow"
brew "neovim"

# Modern CLI replacements
brew "lsd"
brew "eza"
brew "bat"
brew "fd"
brew "ripgrep"
brew "fzf"
brew "jq"

# Runtimes
brew "mise" # Node, Bun, Go; versions in mise/.config/mise/conf.d/personal.toml

# Shell
brew "zsh-autosuggestions"
brew "zsh-completions"
brew "zsh" if OS.linux? # macOS ships zsh

# GUI apps and fonts: Homebrew casks are macOS only.
if OS.mac?
  cask "cmux" # Ghostty-based terminal; reads ~/.config/ghostty/config
  cask "visual-studio-code" # settings arrive through GitHub Settings Sync
  cask "font-meslo-for-powerlevel10k" # "MesloLGS NF": terminal font
  cask "font-fira-code" # editor font
end
