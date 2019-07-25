#!/bin/sh
# Profile file. Runs on login.

# Adds `~/.scripts` and all subdirectories to $PATH
export PATH="$PATH:$(du "$HOME/.scripts/" | cut -f2 | tr '\n' ':')"
export EDITOR="nvim"
export EDITORGUI="nvim"
export TERMINAL="st"
export BROWSER="firefox"
export BROWSERP="firefox -private"
export READER="zathura"
export FILE="vifm"
export FILEGUI="pcmanfm"
export MEDIAPLAYER="mpv"
export SUDO_ASKPASS="$HOME/.scripts/tools/dmenupass"

export INPUTRC="$HOME/.config/inputrc"

export MPD_HOST="127.0.0.1"
export MPD_PORT="6600"

# less/man colors
export LESS=-R
export LESS_TERMCAP_mb="$(printf '%b' '')"; a="${a%_}"
export LESS_TERMCAP_md="$(printf '%b' '')"; a="${a%_}"
export LESS_TERMCAP_me="$(printf '%b' '')"; a="${a%_}"
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"; a="${a%_}"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"; a="${a%_}"
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"; a="${a%_}"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"; a="${a%_}"


echo "$0" | grep "bash$" >/dev/null && [ -f ~/.bashrc ] && source "$HOME/.bashrc"

# Start graphical server if not already running.
[ "$(tty)" = "/dev/tty1" ] && command -v startx && ! pgrep -x Xorg >/dev/null && exec startx
