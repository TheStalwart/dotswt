# This is a legacy config file.
# If you need anything from here,
# move configuration to shell/*
# and convert to OS/shell/arch agnostic code.

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
		export PATH=/opt/local/bin:/opt/local/sbin:/usr/local/sbin:$PATH
		export PATH=~/.dotswt/bin-osx:$PATH

		source ~/.dotswt/bash-completion/android
		source ~/.dotswt/bash-completion/adobe-idb

		export FIGNORE=$FIGNORE:.DS_Store

		if [ -d "/Applications/Xcode.app" ]; then
			export DEVELOPER_DIR="/Applications/Xcode.app/Contents/Developer/"
			alias symbolicatecrash="/Applications/Xcode.app/Contents/SharedFrameworks/DVTFoundation.framework/Versions/A/Resources/symbolicatecrash"
		fi

		if [ -d "/Users/stalwart/SDKs/AIR" ]; then
			export AIR_ROOT="/Users/stalwart/SDKs/AIR"
			export FLEX_SDK=$AIR_ROOT/`ls $AIR_ROOT | head -n 1`
			export PATH=$FLEX_SDK/bin:$PATH
			alias idb="${FLEX_SDK}/lib/aot/bin/iOSBin/idb"
			export PATH=$FLEX_SDK/lib/android/bin:$PATH
			export PATH=$FLEX_SDK/atftools:$PATH
		fi

		if [ -d "/Users/stalwart/SDKs/Imagination" ]; then
			export IMAGINATION_SDK="/Users/stalwart/SDKs/Imagination"
		fi

		if [ -d "$IMAGINATION_SDK" ]; then
			export PATH=$IMAGINATION_SDK/PowerVR_Graphics/PowerVR_Tools/PVRTexTool/CLI/OSX_x86:$PATH
		fi

		if [ -d "$HOME/Library/Android/sdk/ndk-bundle" ]; then
			export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"
			export PATH="$HOME/Library/Android/sdk/ndk-bundle:$PATH"
		fi

		if [ -d "$HOME/.fastlane/bin" ]; then
			export PATH="$HOME/.fastlane/bin:$PATH"
		fi

		# VMware Fusion
		if [ -d "/Applications/VMware Fusion.app/Contents/Library" ]; then
			export PATH=$PATH:"/Applications/VMware Fusion.app/Contents/Library"
		fi

		export STUDIO_VM_OPTIONS=~/.dotswt/studio.vmoptions
		export GRADLE_OPTS=-Xmx2g

		if [ -f `brew --prefix`/bin/rbenv ]; then
			eval "$(rbenv init -)"
		fi

		if [ -f `brew --prefix`/Homebrew/completions/bash/brew ]; then
			source `brew --prefix`/Homebrew/completions/bash/brew
		fi

		if [ -f /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash ]; then
			source /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash
		fi

		if [ -f /usr/local/lib/node_modules/cordova/scripts/cordova.completion ]; then
			source /usr/local/lib/node_modules/cordova/scripts/cordova.completion
		fi

		if [ -d /Applications/Docker.app ]; then
			for f in /Applications/Docker.app/Contents/Resources/etc/*.bash-completion; do
				source $f
			done
		fi

		ane2swc() { unzip $1 catalog.xml library.swf && zip -m ${1%.*}.swc catalog.xml library.swf ; }
		;;
esac

stty -ixon

if [ ${BASH_VERSINFO[0]} -gt 3 ]; then \
	shopt -s autocd
fi

export HISTCONTROL="ignoreboth"
export HISTSIZE=1000

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
alias tree="tree -AC"

alias p="pwd"

alias df="df -h"
alias du="du -h"

alias grep="grep --color=auto"
alias psg='ps aux | grep $*'

if [ -f /usr/local/bin/colorsvn ]; then
	alias svn="colorsvn"
fi

export NETHACKOPTIONS="@$HOME/.dotswt/nethackrc"

