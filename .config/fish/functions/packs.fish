function packs -d "Shows installed packages with information using fzf"
	if type -q fzf
		pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'
	end	
end
