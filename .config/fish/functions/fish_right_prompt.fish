function fish_right_prompt -d "A fish right status definition"
	
	set -l exit_code $status

	# print * if last command ended with errors
	if test $exit_code -ne 0
		set_color red
		echo -n "* "
		set_color normal
	end

	# add date
	set_color yellow
	date "+%d/%m/%y "
	set_color normal

	# add last command duration in seconds
	if test $CMD_DURATION
		set duration (echo "$CMD_DURATION 1000" | awk '{printf "%.3fs", $1 / $2}')
		set_color green
		echo $duration " "
		set_color normal
	end

end
