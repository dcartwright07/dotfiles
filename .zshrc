# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
export ZSH="$HOME/.config/.oh-my-zsh"
export DISABLE_AUTO_TITLE="true"

ulimit -n 4096

# ZSH_THEME="dominic"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  sudo
  history
  zsh-autosuggestions
  zsh-syntax-highlighting
  z
  web-search
  copypath
  jsontools
  nvm
  1password
)

source $ZSH/oh-my-zsh.sh
source ~/Repos/dotfiles/.zshrc_aliases
source ~/Repos/dotfiles/.zshrc_functions

# Created by `pipx` on 2022-07-09 15:20:13
export PATH="$PATH:$HOME/.local/bin"

export PATH="$PATH:$HOME/go/bin"
export NI_CONFIG_FILE="$HOME/.config/ni/nirc"
export CONFIG_DIR="$HOME/.config/lazygit"

# VSCode
[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
