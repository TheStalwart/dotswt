# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

stty -ixon

export HISTCONTROL="ignoredups"

export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}"; echo -ne "\007"'
export PATH=~/.dotswt/bin:$PATH

export EDITOR="vim"
export RPM_PACKAGER="Pavel \"Stalwart\" Shevchuk <stlwrt@gmail.com>"

alias cal="cal -m -3"
alias df="df -h"
alias du="du -h"

alias yu="sudo yum update"
alias ys="yum search"
