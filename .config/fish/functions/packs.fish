function packs -d "Shows installed packages with information using fzf"
	if type -q fzf
		if type -q pacman
			pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'
		end
	end	
end
