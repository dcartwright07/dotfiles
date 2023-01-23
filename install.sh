DOTFILES=$(cd $(dirname "${ZSH_SOURCE[0]}") && pwd)

ln -sv $DOTFILES/.nvm $HOME
ln -sv $DOTFILES/.fig $HOME
ln -sv $DOTFILES/.p10k.zsh $HOME
ln -sv $DOTFILES/.pm $HOME
ln -sv $DOTFILES/.ssh $HOME
ln -sv $DOTFILES/.npmrc $HOME
ln -sv $DOTFILES/.vuerc $HOME
ln -sv $DOTFILES/.zshrc $HOME
ln -sv $DOTFILES/.nuxtrc $HOME
ln -sv $DOTFILES/.z $HOME
ln -sv $DOTFILES/.yarnrc $HOME
ln -sv $DOTFILES/.pls.yml $HOME
ln -sv $DOTFILES/.viminfo $HOME
ln -sv $DOTFILES/.gitconfig $HOME
ln -sv $DOTFILES/.zprofile $HOME
ln -sv $DOTFILES/.wget-hsts $HOME
ln -sv $DOTFILES/.zsh_history $HOME
ln -sv $DOTFILES/.zcompdump $HOME
ln -sv $DOTFILES/.python_history $HOME
ln -sv $DOTFILES/.NERDTreeBookmarks $HOME
ln -sv $DOTFILES/.node_repl_history $HOME
ln -sv $DOTFILES/.npm $HOME
ln -sv $DOTFILES/.asdf $HOME
ln -sv $DOTFILES/.atom $HOME
ln -sv $DOTFILES/.warp $HOME
ln -sv $DOTFILES/.yarn $HOME
ln -sv $DOTFILES/.zsh_sessions $HOME
ln -sv $DOTFILES/.software $HOME
ln -sv $DOTFILES/.composer $HOME
ln -sv $DOTFILES/.node-gyp $HOME
ln -sv $DOTFILES/.dropbox $HOME
ln -sv $DOTFILES/.vscode $HOME
ln -sv $DOTFILES/.docker $HOME
ln -sv $DOTFILES/.phpls $HOME
ln -sv $DOTFILES/.redhat $HOME
ln -sv $DOTFILES/.lpass $HOME
ln -sv $DOTFILES/.cache $HOME
ln -sv $DOTFILES/.mume $HOME
ln -sv $DOTFILES/.swiftpm $HOME
ln -sv $DOTFILES/.tmux.conf $HOME
ln -sv $DOTFILES/.tmuxp $HOME

# Config
rm -rf $HOME/.config/iterm2
ln -sv $DOTFILES/.config/iterm2 $HOME/.config/iterm2

rm -rf $HOME/.config/configstore
ln -sv $DOTFILES/.config/configstore $HOME/.config/configstore

rm -rf $HOME/.config/gh
ln -sv $DOTFILES/.config/gh $HOME/.config/gh

rm -rf $HOME/.config/gh-dash
ln -sv $DOTFILES/.config/gh-dash $HOME/.config/gh-dash

rm -rf $HOME/.config/stripe
ln -sv $DOTFILES/.config/stripe $HOME/.config/stripe

rm -rf $HOME/.config/fish
ln -sv $DOTFILES/.config/fish $HOME/.config/fish

rm -rf $HOME/.config/gtk-2.0
ln -sv $DOTFILES/.config/gtk-2.0 $HOME/.config/gtk-2.0

rm -rf $HOME/.config/exercism
ln -sv $DOTFILES/.config/exercism $HOME/.config/exercism

rm -rf $HOME/.config/spotify-tui
ln -sv $DOTFILES/.config/spotify-tui $HOME/.config/spotify-tui
