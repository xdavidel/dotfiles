function fish_prompt -d "change fish defualt prompt"
    set_color purple
    
    set directory_path (pwd | sed -e "s|^$HOME|~|")

	echo -n (basename $directory_path)

    set_color normal

    echo -n " > "
end
