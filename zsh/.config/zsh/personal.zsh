# --- ENABLE POWERLEVEL10K INSTANT PROMPT ---
# This must stay at the very top of this file!
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Define the OMZ path
export ZSH="$HOME/.oh-my-zsh"

# --- AUTO-INSTALL OH MY ZSH ---
if [ ! -d "$ZSH" ]; then
  echo "Oh My Zsh not found. Installing safely..."
  KEEP_ZSHRC=yes RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# --- AUTO-INSTALL POWERLEVEL10K ---
ZSH_CUSTOM="$ZSH/custom"
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
  echo "Powerlevel10k not found. Installing..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
fi

# --- OH MY ZSH CONFIGURATION ---
# Set the theme to Powerlevel10k
ZSH_THEME="powerlevel10k/powerlevel10k"

# Add your plugins
plugins=(git)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# --- LOAD POWERLEVEL10K SETTINGS ---
# This loads your personal prompt styling
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# --- YOUR PERSONAL ALIASES & EXPORTS GO BELOW ---
# Only alias a replacement when it is installed, so a bare machine still works.
if command -v lsd >/dev/null 2>&1; then alias ls="lsd"; fi
alias ll="ls -la"

if command -v nvim >/dev/null 2>&1; then
  alias vi="nvim"
  alias vim="nvim"
fi
if command -v bat >/dev/null 2>&1; then alias cat="bat"; fi

# Runtimes (Node, Bun, Go) come from mise; versions are in ~/.config/mise/conf.d/personal.toml.
# Skipped when the machine's own .zshrc has already activated mise.
if command -v mise >/dev/null 2>&1 && [[ -z "$MISE_SHELL" ]]; then
  eval "$(mise activate zsh)"
fi
