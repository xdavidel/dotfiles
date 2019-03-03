function pacsize -d "Show all files owned by a package"
	if type -q $argv
		pacman -Qlq $argv | grep -v '/$' | xargs du -h | sort -h
	end
end
