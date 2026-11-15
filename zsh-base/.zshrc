# Base ~/.zshrc for machines where nothing else manages the shell.
# install.sh links this only when no ~/.zshrc exists. On an employer-managed
# machine their .zshrc stays in place and sources personal.zsh instead.

# Homebrew (Apple Silicon, then Linux). Must come first: later lines need its PATH.
for _brew in /opt/homebrew/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
  if [ -x "$_brew" ]; then eval "$("$_brew" shellenv)"; fi
done
unset _brew

# Extra completions from Homebrew. Oh My Zsh runs compinit, so FPATH is set before it loads.
if command -v brew >/dev/null 2>&1; then
  FPATH="$(brew --prefix)/share/zsh-completions:${FPATH}"
fi

# Personal layer: Oh My Zsh, Powerlevel10k, aliases, runtimes.
[ -f "$HOME/.config/zsh/personal.zsh" ] && source "$HOME/.config/zsh/personal.zsh"

if command -v brew >/dev/null 2>&1; then
  _zas="$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  [ -f "$_zas" ] && source "$_zas"
  unset _zas
fi

# Machine-local additions (untracked): work PATHs, tokens, employer tooling.
if [ -f "$HOME/.zshrc.local" ]; then source "$HOME/.zshrc.local"; fi
