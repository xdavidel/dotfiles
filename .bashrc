#!/bin/bash
stty -ixon # Disable ctrl-s and ctrl-q

PS1="\[$(tput bold)\]\[$(tput setaf 5)\]\W\[$(tput sgr0)\] > "

set -o vi

if type ueberzug &>/dev/null; then
	if [ -f ~/.config/vifm/scripts/vifmrun ]; then
		alias vifm='~/.config/vifm/scripts/vifmrun'
	fi
fi

if type wal &>/dev/null; then
	alias cb='wal -i'
fi

alias dotconf='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

[ -f "$HOME/.config/bash/pac-completion.bash" ] && source "$HOME/.config/bash/pac-completion.bash"
