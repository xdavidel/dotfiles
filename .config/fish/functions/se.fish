function se -d "Select configs / scripts for edit"
	if type -q fzf
		du -a ~/.*rc ~/.config ~/.scripts/ | awk '{print $2}' | fzf | xargs -r $EDITOR
	end
end
