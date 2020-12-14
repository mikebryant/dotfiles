# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=200000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
# force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

RED='\033[00;31m'
GREEN='\033[00;32m'
YELLOW='\033[00;33m'
BLUE='\033[00;34m'
PURPLE='\033[00;35m'
CYAN='\033[00;36m'
LIGHTGRAY='\033[00;37m'
LRED='\033[01;31m'
LGREEN='\033[01;32m'
LYELLOW='\033[01;33m'
LBLUE='\033[01;34m'
LPURPLE='\033[01;35m'
LCYAN='\033[01;36m'
WHITE='\033[01;37m'
RESTORE='\033[0m'

# Colors for the PS1 prompt
# For an explanation of the format, please see the Stack Exchange answer
# from Runium (https://unix.stackexchange.com/users/28489/runium)
# at http://unix.stackexchange.com/questions/105958/terminal-prompt-not-wrapping-correctly
PS_RED='\[\033[00;31m\]'
PS_GREEN='\[\033[00;32m\]'
PS_YELLOW='\[\033[00;33m\]'
PS_BLUE='\[\033[00;34m\]'
PS_PURPLE='\[\033[00;35m\]'
PS_CYAN='\[\033[00;36m\]'
PS_LIGHTGRAY='\[\033[00;37m\]'
PS_LRED='\[\033[01;31m\]'
PS_LGREEN='\[\033[01;32m\]'
PS_LYELLOW='\[\033[01;33m\]'
PS_LBLUE='\[\033[01;34m\]'
PS_LPURPLE='\[\033[01;35m\]'
PS_LCYAN='\[\033[01;36m\]'
PS_WHITE='\[\033[01;37m\]'
PS_RESTORE='\[\033[0m\]'

CONTEXT_COLOR=$LRED
PS_CONTEXT_COLOR=$PS_LRED
NAMESPACE_COLOR=$LCYAN
PS_NAMESPACE_COLOR=$PS_LCYAN

if [ "$color_prompt" = yes ]; then
    PS1="($PS_CONTEXT_COLOR\$KUBECTL_CONTEXT$PS_RESTORE/$PS_NAMESPACE_COLOR\$KUBECTL_NAMESPACE$PS_RESTORE)${PS_LGREEN}\u@\h${PS_RESTORE}:${PS_LBLUE}\w${PS_RESTORE}\$ "
else
    PS1='\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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

for f in ${HOME}/.config/bash/*.bashrc; do
  source $f;
done

# Dotfiles

alias dotfiles='/usr/bin/git --git-dir=${HOME}/.dotfiles.git/ --work-tree=${HOME}'
