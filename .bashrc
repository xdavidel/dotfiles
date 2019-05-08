[[ $- != *i* ]] && return

stty -ixon # Disable ctrl-s and ctrl-q

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

if type ueberzug &>/dev/null; then
	if [ -f ~/.config/vifm/scripts/vifmrun ]; then
		alias vifm='~/.config/vifm/scripts/vifmrun'
	fi
fi

if type wal &>/dev/null; then
	alias cb='wal -i'
fi

alias dotconf='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

function cd() {
	new_directory="$*";
	if [ $# -eq 0 ]; then
		new_directory=${HOME};
	fi;
	builtin cd "${new_directory}" && ls
}

function se() {
	if type fzf &>/dev/null; then
		du -a ~/.*rc ~/.config ~/.scripts/ | awk '{print $2}' | fzf | xargs -r $EDITOR
	fi
}

[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"
