#!/usr/bin/fish

set -g user (whoami)
set -g host (prompt_hostname)
set -g dir ($PWD | sed -e "s|^$HOME|~|")

function fish_prompt -d "change fish defualt prompt"

	set_color --bold
	set_color red
	echo -n "["

	set_color yellow
	echo -n $user

	set_color green
	echo -n "@"

	set_color blue
	echo -n $host

	set_color red
	echo -n "]"

	set_color purple
    if test "$PWD" != "$HOME"
        printf " %s\n" (echo $PWD|sed -e 's|/private||' -e "s|^$HOME|~|")
    else
        echo ' ~'
    end
	set_color normal

	# Do nothing if not in vi mode
    if test "$fish_key_bindings" = "fish_vi_key_bindings"
		set_color --bold

		switch $fish_bind_mode
			case default
				set_color -b red
				echo -n "[N]"
			case insert
				set_color -b green
				echo -n "[I]"
			case replace-one
				set_color -b green
				echo -n "[R]"
			case visual
				set_color -b brmagenta
				echo -n "[V]"
			end
		set_color normal
    end

	echo -n " > "
end
