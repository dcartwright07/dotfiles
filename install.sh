DOTFILES=$(cd $(dirname "${ZSH_SOURCE[0]}") && pwd)

rm $HOME/.zshrc
ln -sv $DOTFILES/.zshrc $HOME

rm $HOME/.zsh_history
ln -sv $DOTFILES/.zsh_history $HOME

rm $HOME/.zsh_sessions
ln -sv $DOTFILES/.zsh_sessions $HOME
# ln -sv $DOTFILES/.viminfo $HOME
# ln -sv $DOTFILES/.gitconfig $HOME

rm $HOME/.lpass
ln -sv $DOTFILES/.lpass $HOME

# Config
rm -rf $HOME/.config/iterm2
ln -sv $DOTFILES/iterm2 $HOME/.config/iterm2

rm -rf $HOME/.config/nvim
ln -sv $DOTFILES/nvim $HOME/.config/nvim

rm -rf $HOME/.config/tmux/tmux.conf
ln -sv $DOTFILES/tmux/tmux.conf $HOME/.config/tmux/tmux.conf
