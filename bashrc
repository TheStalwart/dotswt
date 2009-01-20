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

export MC_COLOR_TABLE='normal=,default:selected=,lightgray:marked=,default:markselect=,lightgray:executable=,default:doc=,default:archive=,default:source=,default:media=,default:graph=,default:directory=,default:database=,default'

alias cal="cal -m -3"

alias l="ls"
alias la="ls -a"
alias ll="ls -la"

alias df="df -h"
alias du="du -h"

alias yu="sudo yum update"
alias yi="sudo yum install"
alias yr="sudo yum remove"
alias ys="yum search"
