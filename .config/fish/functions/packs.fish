function packs -d "Shows installed packages with information using fzf"
	if type -q fzf
		if type -q pacman
			pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'
		end
		if type -q pkg
			pkg list-installed | cut -d/ -f1 | fzf --preview 'pkg show {}' --layout=reverse --bind 'enter:execute(pkg show {} | less)'
		end
	end	
end
