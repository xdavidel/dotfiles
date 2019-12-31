#!/bin/bash
stty -ixon # Disable ctrl-s and ctrl-q

export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h\[$(tput setaf 1)\]]\[$(tput setaf 5)\] \W\[$(tput setaf 7)\]\n\[$(tput sgr0)\]> "

# Load the aliases
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"
