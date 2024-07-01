export ZSH="$HOME/.oh-my-zsh"
export CONFIG_DIR="$HOME/.config/lazygit"

plugins=(
    sudo
    zsh-completions
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
source ~/Repos/dotfiles/os/ubuntu/.zshrc_config
source ~/Repos/dotfiles/os/ubuntu/.zshrc_aliases
source ~/Repos/dotfiles/os/ubuntu/.zshrc_functions
