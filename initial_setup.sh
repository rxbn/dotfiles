#!/usr/bin/env bash

set -o errexit

declare -a DOCK_APPS
declare -a FOLDERS

DOCK_APPS=()

FOLDERS=(
  ~/.config/git
  ~/.config/direnv
  ~/.config/zsh
  ~/.config/plugins/zsh
  ~/.config/yamllint
  ~/.config/aerospace
  ~/.config/starship
  ~/.config/tmux
  ~/.config/ghostty
  ~/.config/1Password/ssh
  ~/.cache/zsh
  ~/.ssh
  ~/.kube
  ~/bin
  ~/personal/kubeconfigs
  ~/containeroo
  ~/tmp
)

# Install Rosetta 2
sudo softwareupdate --install-rosetta

# Create folders
for folder in "${FOLDERS[@]}"; do
  mkdir -p "$folder"
done

# Install Homebrew
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
export PATH="/opt/homebrew/bin:$PATH"
brew bundle install # Install all packages

touch ~/.hushlogin # Disable login message

defaults write "Apple Global Domain" AppleReduceDesktopTinting -int 1 # Disable window tinting

defaults write com.apple.dock autohide -int 1      # Automatically hide Dock
defaults write com.apple.dock tilesize -int 50     # Set Dock size
defaults write com.apple.dock magnification -int 1 # Enable magnification
defaults write com.apple.dock largesize -int 80    # Set magnification size
defaults write com.apple.dock show-recents -int 0  # Do not display recent apps

# Configure Dock apps
defaults write com.apple.dock persistent-apps -array
for app in "${DOCK_APPS[@]}"; do
  defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
done

killall Dock

defaults write com.apple.finder _FXSortFoldersFirst -int 1     # Keep folders on top
defaults write com.apple.finder NewWindowTarget -string "PfHo" # New Finder windows open home directory

defaults write -g ApplePressAndHoldEnabled -bool false # Enable key repeat

defaults write NSGlobalDomain _HIHideMenuBar -bool true # Hide menu bar

# Install zsh plugins
git clone https://github.com/catppuccin/zsh-syntax-highlighting.git ~/.config/plugins/zsh/catppuccin-zsh-syntax-highlighting
git clone https://github.com/ahmetb/kubectl-aliases.git ~/.config/plugins/zsh/kubectl-aliases

# Install kubectl plugins
kubectl krew update
kubectl krew install cnpg
kubectl krew install neat
kubectl krew install node-shell
kubectl krew install resource-capacity
kubectl krew install tree

# Configure pyenv
# renovate datasource=github-tags depName=python/cpython
PYTHON_VERSION=v3.13.3
pyenv install ${PYTHON_VERSION//v/}
pyenv global ${PYTHON_VERSION//v/}

# Disable animations when opening and closing windows.
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# Accelerated playback when adjusting the window size.
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

repo_path=$(pwd)

# Create symlinks
ln -sf "${repo_path}/zprofile" ~/.zprofile
ln -sf "${repo_path}/personal/ssh/config" ~/.ssh/config
ln -sf "${repo_path}/config/zsh/aliasrc" ~/.config/zsh/aliasrc
ln -sf "${repo_path}/config/starship/starship.toml" ~/.config/starship/starship.toml
ln -sf "${repo_path}/config/git/config" ~/.config/git/config
ln -sf "${repo_path}/personal/config/git/personal.conf" ~/.config/git/personal.conf
ln -sf "${repo_path}/config/direnv/direnv.toml" ~/.config/direnv/direnv.toml
ln -sf "${repo_path}/config/aerospace/aerospace.toml" ~/.config/aerospace/aerospace.toml
ln -sf "${repo_path}/config/nvim" ~/.config/nvim
ln -sf "${repo_path}/config/tmux/tmux.conf" ~/.config/tmux/tmux.conf
ln -sf "${repo_path}/config/zsh/zshrc" ~/.config/zsh/.zshrc
ln -sf "${repo_path}/config/yamllint/config" ~/.config/yamllint/config
ln -sf "${repo_path}/config/ghostty/config" ~/.config/ghostty/config
ln -sf "${repo_path}/bin/ansible-vault-pass" ~/bin/ansible-vault-pass
ln -sf "${repo_path}/bin/tmux-sessionizer" ~/bin/tmux-sessionizer
ln -sf "${repo_path}/bin/tmux-sshionizer" ~/bin/tmux-sshionizer
ln -sf "${repo_path}/personal/config/1Password/ssh/agent.toml" ~/.config/1Password/ssh/agent.toml

echo "Done! Please restart your computer."
