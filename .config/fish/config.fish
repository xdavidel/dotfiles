fish_vi_key_bindings

export EDITOR=vim

if type -q lsd
	alias l='lsd -l'
	alias ls='lsd'
	alias ll='lsd -la'
	alias la='lsd -a'
else
	alias l='ls -lh'
	alias la='ls -A'
	alias ll='ls -lAh'
end

if type -q ueberzug
	if test -e ~/.config/vifm/scripts/vifmrun
		alias vifm='~/.config/vifm/scripts/vifmrun'
	end
end

if type -q wal
	alias cb='wal -i'
end

alias dotconf='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

