fish_vi_key_bindings

export EDITOR=vim

if type -q lsd
	alias l='lsd -l'
	alias ls='lsd'
	alias ll='lsd -la'
	alias la='lsd -a'
else
	alias l='ls -l'
end

alias dotconf='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

