#!/usr/bin/env bash
# =============================================================================
# Fresh-Mac setup for these dotfiles. Safe to re-run (idempotent).
#
#   Bootstrap on a brand-new machine:
#     xcode-select --install
#     git clone https://github.com/dcartwright07/dotfiles.git ~/Repos/dotfiles
#     ~/Repos/dotfiles/mac/install.sh
# =============================================================================
set -uo pipefail

# --- Locate the repo (this script lives in <repo>/mac) -----------------------
DOTFILES="$(cd "$(dirname "$0")/.." && pwd)"
MAC="$DOTFILES/mac"
info() { printf "\033[1;36m==>\033[0m %s\n" "$*"; }

# Symlink helper: link <target> <linkname>, backing up any real file in the way.
link() {
  local target="$1" name="$2"
  mkdir -p "$(dirname "$name")"
  if [ -e "$name" ] && [ ! -L "$name" ]; then
    info "Backing up existing $name -> $name.bak"
    mv "$name" "$name.bak"
  fi
  ln -sfn "$target" "$name"
  info "linked $name -> $target"
}

# --- Xcode command line tools ------------------------------------------------
if ! xcode-select -p >/dev/null 2>&1; then
  info "Installing Xcode command line tools..."
  xcode-select --install || true
fi

# --- Homebrew ----------------------------------------------------------------
if ! command -v brew >/dev/null 2>&1; then
  info "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# --- Homebrew formulae -------------------------------------------------------
info "Installing Homebrew formulae..."
brew install \
  neovim \
  tmux \
  lazygit \
  lazydocker \
  pnpm \
  yarn \
  fzf \
  bat \
  bat-extras \
  lsd \
  zoxide \
  starship \
  tree \
  tig \
  ack \
  glow \
  gum \
  pipx \
  gh \
  mycli \
  pgcli \
  nvm \
  speedtest \
  tldr \
  tiptop \
  nushell \
  python

# fjira (Jira TUI, `j` alias) — lives in a tap
brew install mk-5/fjira/fjira || info "fjira install skipped (check tap: brew tap mk-5/fjira)"

# --- Homebrew casks ----------------------------------------------------------
info "Installing Homebrew casks..."
brew install --cask ghostty
brew install --cask 1password/tap/1password-cli

# --- pipx packages -----------------------------------------------------------
pipx install pls || true

# --- Oh My Zsh + plugins + theme ---------------------------------------------
export ZSH="$HOME/.config/.oh-my-zsh"
if [ ! -d "$ZSH" ]; then
  info "Installing Oh My Zsh..."
  RUNZSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
ZSH_CUSTOM="${ZSH_CUSTOM:-$ZSH/custom}"
[ -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] || \
  git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
[ -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] || \
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
link "$MAC/dominic.zsh-theme" "$ZSH_CUSTOM/themes/dominic.zsh-theme"

# --- Node global tools -------------------------------------------------------
# `ni` (uses NI_CONFIG_FILE -> ~/.config/ni/nirc). Requires node (via nvm).
if command -v npm >/dev/null 2>&1; then
  npm install -g @antfu/ni || info "ni install skipped"
fi

# --- Config symlinks ---------------------------------------------------------
info "Linking config files..."
link "$DOTFILES/nvim"                 "$HOME/.config/nvim"
link "$DOTFILES/tmux/tmux.conf"       "$HOME/.config/tmux/tmux.conf"
link "$DOTFILES/bat"                  "$HOME/.config/bat"
link "$DOTFILES/btop"                 "$HOME/.config/btop"
link "$DOTFILES/lazygit"              "$HOME/.config/lazygit"
link "$DOTFILES/ni/.nirc"             "$HOME/.config/ni/nirc"
link "$DOTFILES/starship.toml"        "$HOME/.config/starship.toml"
link "$MAC/config"                    "$HOME/Library/Application Support/com.mitchellh.ghostty/config"
link "$DOTFILES/.gitconfig"           "$HOME/.gitconfig"
link "$DOTFILES/.gitignore_global"    "$HOME/.gitignore_global"
link "$MAC/.ideavimrc"                "$HOME/.ideavimrc"

# --- Local ~/.zshrc from template (holds secrets; never clobbered) -----------
if [ ! -f "$HOME/.zshrc" ]; then
  info "Creating ~/.zshrc from template — fill in secrets before use."
  cp "$MAC/zshrc.template" "$HOME/.zshrc"
else
  info "~/.zshrc already exists — leaving it (edit secrets there directly)."
fi

info "Done. Open a new terminal (or run: source ~/.zshrc)."
info "Reminder: put real secrets in ~/.zshrc (GITHUB_PERSONAL_ACCESS_TOKEN, etc.)."
