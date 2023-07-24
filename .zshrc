export ZSH="$HOME/.config/.oh-my-zsh"
export DISABLE_AUTO_TITLE="true"

ulimit -n 4096

ZSH_THEME="dominic"

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

alias v="nvim"
alias edit="nvim ~/.zshrc"
alias refresh="source ~/.zshrc"
alias ztheme="nvim ~/.config/.oh-my-zsh/themes/dominic.zsh-theme"
alias nv-config="cd ~/.config/nvim/lua/user/; nvim"
alias edit-dash="nvim ~/.config/gh-dash/config.yml"
alias tmux-config="nvim ~/.config/tmux/tmux.conf"
alias kitty-config="cd ~/.config/kitty/; nvim"
alias ssh='TERM=xterm-256color ssh'

alias composer="php /usr/local/bin/composer"
alias hosts="sudo code -r /etc/hosts"
alias editKeys="code -r ~/.ssh/known_hosts"
alias listen="lsof -nP | grep LISTEN"
# alias killport="lsof -P | grep ':${1}' | awk '\''{print $2}'\'' | xargs kill -9"
alias listByDate="find ${1} -type f | xargs stat --format '%Y :%y %n' 2>/dev/null | sort -nr | cut -d: -f2-"
alias ip-p="curl ifconfig.me"
alias ip="ifconfig en0 | grep inet"
alias password="security find-generic-password"
alias cpass="op items list | fzf | awk '{print \$1}' | xargs -I % sh -c 'op item get % --fields label=password' | pbcopy"
alias fpass="op items list | fzf | awk '{print \$1}' | xargs -I % sh -c 'op item get % --fields label=password'"
alias spass="op items list | fzf | awk '{print \$1}' | xargs -I % sh -c 'op item get %'"

# JIRA CLI
alias j-api='export JIRA_API_TOKEN="$(op item get ghdlcpljnax5pu5ncy7oqqxthe --fields credential)"'
alias j-issues="jira issue list -s~Done -s~Closed -s~'Stakeholder Review' -s~'Stake Holder Review Done' -s~'Quality Assurance' -p ${1}"
alias j-projects="jira project list"
alias j-issue="jira issue view ${1}"
alias j-mine="jira issue list -a \$(jira me) -s~DONE -s~Closed -s~'Stakeholder Review' -s~'Stake Holder Review Done' -s~'Quality Assurance' -p ${1}"

alias d-view="lazydocker"
alias d="docker"

# Package Managers
alias binstall='brew list | gum filter --placeholder "Choose a package to install" | xargs brew install'

# Laravel Projects
alias sail="[ -f sail ] && sh sail || sh vendor/bin/sail"
alias art="sail artisan"
alias routes="sail artisan route:list --except-vendor"

# Github
alias bugs="gh issue list -l bug"
alias my-issues="gh issue list -a @me"
alias issues="gh issue list"
alias feats="gh issue list -l enhancement"
alias prs="gh pr list"
alias gh-squash="gh pr list | fzf | awk '{print \$1}' | xargs -I % sh -c 'gh pr merge % -d --squash'; ggpull"

# Git
alias g-undo="git reset --soft HEAD~1"

alias sys="tiptop"
alias wConfig="nvim ~/Library/Application\ Support/watson/config"
alias timer="watson"
alias ls="pls --multi-cols"
alias load="tmuxp load"
alias f="fzf"
alias lg="lazygit"

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

eval "$(op completion zsh)"; compdef _op op

mysql_db() {
  target_db=$1
  db_type=$2

  echo "Connecting to $target_db $db_type"

  if [ "$target_db" = "wu247" ] && [ "$db_type" = "local" ]; then
    item="rx64r7b3dbteulho7wj7umd5oq"
  fi

  local username="$(op item get $item --fields username)"
  local password="$(op item get $item --fields password)"
  local host="$(op item get $item --fields server)"
  local port="$(op item get $item --fields port)"
  local database="$(op item get $item --fields database)"
  mycli -h $host -P $port -u $username -p $password $database
}

postgres_db() {
  target_db=$1
  db_type=$2

  echo "Connecting to $target_db $db_type"

  if [ "$db_type" = "local" ]; then

    if [ "$target_db" = "moodle" ]; then
      username="moodle"
      password="m%400dl3ing"
      host="localhost"
      port="5432"
      database=$target_db
    fi

  else

    if [ "$target_db" = "psql04" ] && [ "$target_db" = "dev" ]; then
      item="rwzzcgf3yxndu2dzs2bssqkyfm"
    fi

    username="$(op item get $item --fields username)"
    password="$(op item get $item --fields password)"
    host="$(op item get $item --fields server)"
    port="$(op item get $item --fields port)"
    database="$(op item get $item --fields database)"

  fi

  echo postgres://$username:$password@$host:$port/$database

  pgcli postgres://$username:$password@$host:$port/$database
}

# Created by `pipx` on 2022-07-09 15:20:13
export PATH="$PATH:$HOME/.local/bin"

export PATH="$PATH:$HOME/go/bin"
export NI_CONFIG_FILE="$HOME/.config/ni/nirc"
export CONFIG_DIR="$HOME/.config/lazygit"

