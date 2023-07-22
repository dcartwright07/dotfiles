mkdir -p ~/Repos
git clone https://github.com/dcartwright07/dotfiles.git ~/Repos
DOTFILES=$(cd $(dirname "${ZSH_SOURCE[0]}") && pwd)

# Install MacOS command line tools
xcode-select --install

# Install Homebrew Packages
brew install nvim
brew install tmux
brew install lazygit
brew install pnpm
brew install yarn
brew install fzf
brew install bat
brew install --cask 1password/tap/1password-cli
brew install tree
brew install tig
brew install ack
brew install glow
brew install gum
brew install pipx
brew install pip3
brew install gh
brew install mycli
brew install pgcli
brew install nvm
brew install speedtest
brew install tldr

# Install Pipx Packages
pipx install pls

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting


rm $HOME/.zshrc
ln -sv $DOTFILES/.zshrc $HOME

# ln -sv $DOTFILES/.viminfo $HOME
# ln -sv $DOTFILES/.gitconfig $HOME

# Config
rm -rf $HOME/.config/nvim
ln -sv $DOTFILES/nvim $HOME/.config/nvim

rm -rf $HOME/.config/tmux/tmux.conf
ln -sv $DOTFILES/tmux/tmux.conf $HOME/.config/tmux/tmux.conf
