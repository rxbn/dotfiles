# Profile file. Runs on login. Environmental variables are set here.

# Add local bin to $PATH
export PATH="${PATH}:${HOME}/bin:$HOME/.krew/bin:${HOME}/.local/bin"

# Add Homebrew to $PATH
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:${PATH}"

# ~/ Clean-up
export ZDOTDIR="${HOME}/.config/zsh"

export EDITOR="nvim"

# Color vars
export NOCOLOR='\033[0m'
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export ORANGE='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export LIGHTGRAY='\033[0;37m'
export DARKGRAY='\033[1;30m'
export LIGHTRED='\033[1;31m'
export LIGHTGREEN='\033[1;32m'
export YELLOW='\033[1;33m'
export LIGHTBLUE='\033[1;34m'
export LIGHTPURPLE='\033[1;35m'
export LIGHTCYAN='\033[1;36m'
export WHITE='\033[1;37m'

# Ansible
export ANSIBLE_VAULT_PASSWORD_FILE="~/bin/ansible-vault-pass"
export ANSIBLE_INVENTORY="hosts.yml"
export ANSIBLE_PYTHON_INTERPRETER=auto_silent

# Homebrew
export HOMEBREW_NO_ANALYTICS=1

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# Starship
export STARSHIP_CONFIG="${HOME}/.config/starship/starship.toml"

# Personal env vars
source ~/.config/zsh/personal_env
# vi: ft=zsh
