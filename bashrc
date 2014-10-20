# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

case `uname -s` in
	Linux )
		export LANG=ru_RU.UTF-8
		export LC_MESSAGES=en_US.UTF-8
		alias man="LANG=en_US.UTF-8 man"

		export PATH=~/.dotswt/bin:$PATH

		export GTK2_RC_FILES=/etc/gtk-2.0/gtkrc:/home/stalwart/.dotswt/gtkrc-2.0

		export SDL_AUDIODRIVER=alsa

		export RPM_PACKAGER="Pavel \"Stalwart\" Shevchuk <stlwrt@gmail.com>"

		alias gq="geeqie"
		alias fm="dolphin ."
		alias cal="cal -m -3"

		alias yu="sudo yum update"
		alias yi="sudo yum install"
		alias yr="sudo yum remove"
		alias ys="yum search"

		urxvtfix() { scp /usr/share/terminfo/r/rxvt-unicode $1:/usr/share/terminfo/r/ ; }
		;;
	Darwin )
		export PATH=/opt/local/bin:/opt/local/sbin:/usr/local/mysql/bin:/usr/local/sbin:$PATH
		export PATH=~/.dotswt/bin-osx:$PATH

		alias adb="/Users/stalwart/Projects/cte/adt-bundle-mac-x86_64-20140702/sdk/platform-tools/adb"
		source ~/.dotswt/bash-completion/android

		export FIGNORE=$FIGNORE:.DS_Store

		export ANT_OPTS="-Xmx4096M"
		#export _JAVA_OPTIONS="-Xmx4096M"

		export FLEX_SDK="/Users/stalwart/Projects/Flex"
		if [ -d "$FLEX_SDK" ]; then
			export PATH=$FLEX_SDK/bin:$PATH
			alias idb="${FLEX_SDK}/lib/aot/bin/iOSBin/idb"
		fi

		if [ -f `brew --prefix`/etc/bash_completion ]; then
			. `brew --prefix`/etc/bash_completion
		fi

		if [ -f /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash ]; then
			source /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash
		fi
		;;
esac

stty -ixon

if [ ${BASH_VERSINFO[0]} -gt 3 ]; then \
  shopt -s autocd
fi

export HISTCONTROL="ignoreboth"

export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}"; echo -ne "\007"'
export CDPATH=.:~

export EDITOR="vim"

export WINEDEBUG="-all"

MC_COLOR_BASE='normal=,default:selected=,lightgray:marked=,default:markselect=,lightgray:errors=,:input=default,default:reverse=,:gauge=,'
MC_COLOR_SPECIAL='executable=,default:directory=,default:link=,default:stalelink=,default:device=,default:special=gray,default:core=,default'
MC_COLOR_FILETYPES='hidden=gray,default:temp=,default:doc=,default:archive=,default:source=,default:media=,default:graph=,default:database=,default'
export MC_COLOR_TABLE=$MC_COLOR_BASE:$MC_COLOR_SPECIAL:$MC_COLOR_FILETYPES

export SCREENRC=~/.dotswt/screenrc

alias s="screen -DRR"

export CLICOLOR=1
alias l="ls"
alias la="ls -a"
alias ll="ls -la"

alias p="pwd"

alias df="df -h"
alias du="du -h"

alias grep="grep --color=auto"
alias psg='ps aux | grep $*'

if [ -f /usr/local/bin/colorsvn ]; then
	alias svn="colorsvn"
fi

