#!/bin/sh

export PATH=${HOME}/.local/share/bin:$PATH


# Bash
## Enable Bash completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if which kubectl >/dev/null; then
  source <(kubectl completion bash)
fi


# Python
if [ -e /usr/share/virtualenvwrapper/virtualenvwrapper_lazy.sh ]; then
  source /usr/share/virtualenvwrapper/virtualenvwrapper_lazy.sh
fi

export REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt


# XDG
export RIPGREP_CONFIG_PATH="${HOME}/.config/ripgrep/config"

# Kubernetes
## Make watch an alias so it works with k8sh
alias watch='watch '

source ${HOME}/.config/bash/*.bashrc

# Dotfiles

alias dotfiles='/usr/bin/git --git-dir=${HOME}/.dotfiles.git/ --work-tree=${HOME}'
