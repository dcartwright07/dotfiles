export ZSH="$HOME/.config/.oh-my-zsh"
export DISABLE_AUTO_TITLE="true"

ZSH_THEME="dominic"

plugins=(
  git
  sudo
  history
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-z
  web-search
  copypath
  jsontools
  dash
  lpass
  nvm
)

source $ZSH/oh-my-zsh.sh

alias v="nvim"
alias edit="nvim ~/.zshrc"
alias ztheme="nvim ~/.config/.oh-my-zsh/themes/dominic.zsh-theme"
alias nv-config="cd ~/.config/nvim/lua/user/; nvim"
alias edit-dash="nvim ~/.config/gh-dash/config.yml"
alias tmux-config="nvim ~/.config/tmux/tmux.conf"
alias kitty-config="cd ~/.config/kitty/; nvim"

alias composer="php /usr/local/bin/composer"
alias hosts="sudo code -r /etc/hosts"
alias editApache="sudo code -r /etc/apache2/httpd.conf"
alias editVhosts="sudo code -r /etc/apache2/extra/httpd-vhosts.conf"
alias editKeys="code -r ~/.ssh/known_hosts"
alias listen="lsof -nP | grep LISTEN"
alias listByDate="find ${1} -type f | xargs stat --format '%Y :%y %n' 2>/dev/null | sort -nr | cut -d: -f2-"
alias ip-p="curl ifconfig.me"
alias ip="ifconfig en0 | grep inet"
alias password="security find-generic-password"

alias db="mycli -h localhost -P 3306 -u dominic -p KimC2013"

alias d-view="lazydocker"
alias d="docker"

# Laravel Projects
alias sail="[ -f sail ] && sh sail || sh vendor/bin/sail"
alias art="sail artisan"
alias routes="sail artisan route:list --except-vendor"

# Ethode Specific
alias live-push="npx gulp live-push"

# Github
alias bugs="gh issue list -l bug"
alias my-issues="gh issue list -a @me"
alias issues="gh issue list"
alias feats="gh issue list -l enhancement"
alias prs="gh pr list"

alias sys="tiptop"
alias wConfig="nvim ~/Library/Application\ Support/watson/config"
alias timer="watson"
alias ls="pls --multi-cols"
alias pip="pip3"
alias python="python3"
alias load="tmuxp load"

## Functions ===============
# NVM
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Auto Assign Version if Project has .nvmrc file
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# Created by `pipx` on 2022-07-09 15:20:13
export PATH="$PATH:$HOME/.local/bin"

# export PATH="$PATH:/Users/dominiccartwright/.local/share"
