export ZSH="$HOME/.config/.oh-my-zsh"
export DISABLE_AUTO_TITLE="true"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:/opt/homebrew/bin"
export PATH="$PATH:$HOME/development/flutter/bin:$PATH"
export PATH="$PATH:$HOME/.gem/bin:$PATH"
export NI_CONFIG_FILE="$HOME/.config/ni/nirc"
export CONFIG_DIR="$HOME/.config/lazygit"
export LAUNCH_EDITOR="webstorm"
export SSH_AUTH_SOCK="~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock"

ulimit -n 4096

plugins=(
  sudo
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
source ~/Repos/dotfiles/os/mac/.zshrc_config
source ~/Repos/dotfiles/os/mac/.zshrc_aliases
source ~/Repos/dotfiles/os/mac/.zshrc_functions
