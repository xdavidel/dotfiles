#!/usr/bin/env bash

_pac_completions()
{
	if [ "${#COMP_WORDS[@]}" != 2 ]; then
		return
	fi

	COMPREPLY+=($(compgen -W "install update remove mirror list show download getall orphan cache" "${COMP_WORDS[1]}"))
}

complete -F _pac_completions pac
