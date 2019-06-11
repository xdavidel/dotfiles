#!/bin/bash
stty -ixon # Disable ctrl-s and ctrl-q

PS1="\[$(tput bold)\]\[$(tput setaf 5)\]\W\[$(tput sgr0)\] > "

set -o vi

if type exa &>/dev/null; then
	alias l='exa -lF'
	alias ls='exa -F'
	alias ll='exa -laF'
	alias la='exa -aF'
else
	alias l='ls -lh --color=auto --group-directories-first'
	alias ls='ls --color=auto --group-directories-first'
	alias la='ls -A --color=auto --group-directories-first'
	alias ll='ls -lAh --color=auto --group-directories-first'
fi

if type ueberzug &>/dev/null; then
	if [ -f ~/.config/vifm/scripts/vifmrun ]; then
		alias vifm='~/.config/vifm/scripts/vifmrun'
	fi
fi

if type wal &>/dev/null; then
	alias cb='wal -i'
fi

alias dotconf='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

#function cd() {
#	new_directory="$*";
#	if [ $# -eq 0 ]; then
#		new_directory=${HOME};
#	fi;
#	builtin cd "${new_directory}" && ls
#}

[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"
