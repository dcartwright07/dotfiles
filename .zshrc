# Fig pre block. Keep at the top of this file.
# [[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
#
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="/Users/dominiccartwright/.oh-my-zsh"
export DISABLE_AUTO_TITLE="true"

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
# ZSH_THEME="dominic"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
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
  macos
  pm
  dash
  gh
  lpass
  fd
  nvm
  # composer
  brew
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
  # export EDITOR='nvim'
# fi


# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias v="nvim"
alias edit="nvim ~/.zshrc"
alias nv-config="nvim ~/.config/nvim/lua/user/"
alias edit-dash="nvim ~/.config/gh-dash/config.yml"
alias tmux-config="nvim ~/.tmux.conf"

alias composer="php /usr/local/bin/composer"
alias restart="sudo apachectl restart"
alias mysql="/usr/local/mysql/bin/mysql -u root"
alias sites="cd ~/Sites"
alias hosts="sudo code -r /etc/hosts"
alias editApache="sudo code -r /etc/apache2/httpd.conf"
alias editVhosts="sudo code -r /etc/apache2/extra/httpd-vhosts.conf"
alias editKeys="code -r ~/.ssh/known_hosts"
alias listen="lsof -nP | grep LISTEN"
alias listByDate="find ${1} -type f | xargs stat --format '%Y :%y %n' 2>/dev/null | sort -nr | cut -d: -f2-"
alias ip-p="curl ifconfig.me"

alias db="mycli -h localhost -P 3306 -u dominic -p KimC2013"

alias sshBGC="ssh bgcgran@192.254.143.28"
alias sshHEC="ssh -p 2222 hamiltoneye@50.87.149.74"
alias sshBI="ssh -p 2222 bccfbi@192.185.71.147"

alias dl-wu247="source ~/.dotfiles/whatsup247/.env-local; cd ~/Sites/whatsup247; docker compose up -d; cd ~/Sites/whatsup247/app"
alias dt-wu247="source ~/.dotfiles/whatsup247/.env-test; cd ~/Sites/whatsup247; docker compose up -d; cd ~/Sites/whatsup247/app"
alias d-up="docker compose up -d"
alias d-down="docker compose down"
alias d-clean="docker compose down --volumes"
alias d-mysql="docker exec -it database mysql -u root -p wu247"
alias d-migrate="docker exec app bash migrate.sh"
alias d-view="lazydocker"
alias d="docker"

# Laravel Projects
alias sail="[ -f sail ] && sh sail || sh vendor/bin/sail"
alias art="sail artisan"
alias routes="sail artisan route:list --except-vendor"

# Ethode Specific
alias live-push="npx gulp live-push"

alias stripe-listen="stripe listen --forward-to local.whatsup247.com/organization/g/stripe"

# alias s="cmatrix -s -u 10 -C red"
alias sys="tiptop"
alias wConfig="nvim ~/Library/Application\ Support/watson/config"
alias timer="watson"
alias ls="pls --multi-cols"
alias pip="pip3"
alias python="python3"
alias load="tmuxp load"

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

# PM functions
source /Users/dominiccartwright/.pm/pm.zsh
alias pma="pm add"
alias pmg="pm go"
alias pmrm="pm remove"
alias pml="pm list"
# end PM

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Created by `pipx` on 2022-07-09 15:20:13
export PATH="$PATH:/Users/dominiccartwright/.local/bin"

# export PATH="$PATH:/Users/dominiccartwright/.local/share"

# Fig post block. Keep at the bottom of this file.
# [[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
