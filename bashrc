# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export LANG=ru_RU.UTF-8
export LC_MESSAGES=en_US.UTF-8

# User specific aliases and functions

stty -ixon

if [ ${BASH_VERSINFO[0]} -gt 3 ]; then \
  shopt -s autocd
fi

export HISTCONTROL="ignoreboth"

export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}"; echo -ne "\007"'
export PATH=~/.dotswt/bin:$PATH
export CDPATH=.:~


export EDITOR="vim"
export RPM_PACKAGER="Pavel \"Stalwart\" Shevchuk <stlwrt@gmail.com>"

export WINEDEBUG="-all"
export SDL_AUDIODRIVER=alsa

MC_COLOR_BASE='normal=,default:selected=,lightgray:marked=,default:markselect=,lightgray:errors=,:input=default,default:reverse=,:gauge=,'
MC_COLOR_SPECIAL='executable=,default:directory=,default:link=,default:stalelink=,default:device=,default:special=gray,default:core=,default'
MC_COLOR_FILETYPES='hidden=gray,default:temp=,default:doc=,default:archive=,default:source=,default:media=,default:graph=,default:database=,default'
export MC_COLOR_TABLE=$MC_COLOR_BASE:$MC_COLOR_SPECIAL:$MC_COLOR_FILETYPES

export SCREENRC=~/.dotswt/screenrc

alias cal="cal -m -3"
alias gq="geeqie"
alias s="screen -DRR"

alias l="ls"
alias la="ls -a"
alias ll="ls -la"

alias df="df -h"
alias du="du -h"

alias yu="sudo yum update"
alias yi="sudo yum install"
alias yr="sudo yum remove"
alias ys="yum search"

alias grep="grep --color=auto"

alias man="LANG=en_US.UTF-8 man"
