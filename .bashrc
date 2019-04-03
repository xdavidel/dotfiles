#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
PS1='\[\033[01;35m\]\W \[\033[01;00m\]> '
#PS1='[\u@\h \W]\$ '

set -o vi

if type lsd &>/dev/null; then
	alias l='lsd -l'
	alias ls='lsd'
	alias ll='lsd -la'
	alias la='lsd -a'
else
	alias l='ls -lh --color=auto --group-directories-first'
	alias ls='ls --color=auto --group-directories-first'
	alias la='ls -A --color=auto --group-directories-first'
	alias ll='ls -lAh --color=auto --group-directories-first'
fi

if type wal &>/dev/null; then
	alias cb='wal -i'
fi

#alias l='ls -lh --color=auto --group-directories-first'
#alias ls='ls --color=auto --group-directories-first'
#alias la='ls -A --color=auto --group-directories-first'
#alias ll='ls -lAh --color=auto --group-directories-first'

alias dotconf='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

function cd() {
	new_directory="$*";
	if [ $# -eq 0 ]; then 
		new_directory=${HOME};
	fi;
	builtin cd "${new_directory}" && ls
}
