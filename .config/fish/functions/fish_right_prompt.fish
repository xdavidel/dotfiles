function fish_right_prompt -d "A fish right status definition"
	set -l exit_code $status

	# print if last command ended with errors
	if test $exit_code -ne 0
		set_color red
		echo -n "[$exit_code] "
		set_color normal
	end

	set_color yellow
	date "+%H:%M:%S "
	set_color normal

end
