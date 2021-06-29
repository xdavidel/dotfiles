#!/bin/bash
stty -ixon # Disable ctrl-s and ctrl-q

COLOR_RED="\033[0;31m"
COLOR_YELLOW="\033[0;33m"
COLOR_GREEN="\033[0;32m"
COLOR_OCHRE="\033[38;5;95m"
COLOR_BLUE="\033[0;34m"
COLOR_WHITE="\033[0;37m"
COLOR_RESET="\033[0m"

git_status() {
    local statc="$COLOR_RESET" # assume none
    local bname="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"

    if [ -n "$bname" ]; then
        local rs="$(git status --porcelain -b 2>/dev/null)"
        if $(echo "$rs" | grep -v '^##' &> /dev/null); then # is dirty
            statc="$COLOR_RED"
        elif $(echo "$rs" | grep '^## .*diverged' &> /dev/null); then # has diverged
            statc="$COLOR_RED"
        elif $(echo "$rs" | grep '^## .*behind' &> /dev/null); then # is behind
            statc="$COLOR_YELLOW"
        elif $(echo "$rs" | grep '^## .*ahead' &> /dev/null); then # is ahead
            statc="$COLOR_OCHRE"
        else # is clean
            statc="$COLOR_GREEN"
        fi
        echo -e " $statc($bname)$COLOR_RESET"
    else
        echo -n ""
    fi
}

export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h\[$(tput setaf 1)\]]\[$(tput setaf 5)\] \W\[$(tput sgr0)\]\$(git_status)\n# "

# Load the aliases
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"
