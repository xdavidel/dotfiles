#!/bin/bash
stty -ixon # Disable ctrl-s and ctrl-q

ANSI_ESC="\033"
ANSI_CSI="${ANSI_ESC}["
ANSI_OSC="${ANSI_ESC}]"
ANSI_ST="${ANSI_ESC}\\"

COLOR_RED="${ANSI_CSI}31m"
COLOR_YELLOW="${ANSI_CSI}33m"
COLOR_GREEN="${ANSI_CSI}32m"
COLOR_OCHRE="${ANSI_CSI}95m"
COLOR_BLUE="${ANSI_CSI}34m"
COLOR_WHITE="${ANSI_CSI}37m"
COLOR_BOLD="${ANSI_CSI}1m"
COLOR_RESET="${ANSI_CSI}0m"

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
        echo -e " $statc($bname)"
    else
        echo -n ""
    fi
}

export PS1="\[${COLOR_BOLD}\]\[${COLOR_RED}\][\[${COLOR_YELLOW}\]\u\[${COLOR_GREEN}\]@\[${COLOR_BLUE}\]\h\[${COLOR_RED}\]]\[${COLOR_OCHRE}\] \w\[${COLOR_RESET}\]\$(git_status)\[${COLOR_RESET}\]\n# "

# Load the aliases
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"
