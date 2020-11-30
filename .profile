#!/bin/sh
# Profile file. Runs on login.

# Adds `~/.scripts` and all subdirectories to $PATH
export PATH="$PATH:$HOME/.local/scripts/"
export EDITOR="nvim"
export EDITORGUI="nvim"
export TERMINAL="st"
export BROWSER="brave"
export BROWSERP="brave --incognito"
export READER="zathura"
export FILE="vifm"
export FILEGUI="pcmanfm"
export MEDIAPLAYER="mpv"

export _JAVA_AWT_WM_NONREPARENTING=1	# Fix for Java applications in dwm
export QT_QPA_PLATFORMTHEME="gtk2"	    # Have QT use gtk2 theme.
export MOZ_USE_XINPUT2="1"		        # Mozilla smooth scrolling/touchpads.

# No place like home
export LESSHISTFILE="-"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export INPUTRC="${XDG_CONFIG_HOME:-$HOME/.config}/inputrc"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export DOCKER_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/docker"
export ANDROID_SDK_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/android"
export ALSA_CONFIG_PATH="${XDG_CONFIG_HOME:-$HOME/.config}/alsa/asoundrc"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/npm/npmrc"
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc-2.0"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
# export GNUPGHOME="${XDG_DATA_HOME:-$HOME/.local/share}/gnupg"
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export RUSTUP_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/rustup"
export WINEPREFIX="${XDG_DATA_HOME:-$HOME/.local/share}/wineprefixes/default"
export PYLINTHOME="${XDG_CACHE_HOME:-$HOME/.cache}/pylint"
export SUDO_ASKPASS="$HOME/.local/scripts/dmenupass"

# MPD
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
export LESSOPEN="| /usr/bin/highlight -O ansi %s 2>/dev/null"

# Start graphical server if not already running.
[ "$(tty)" = "/dev/tty1" ] && command -v startx && ! pgrep -x Xorg >/dev/null && exec startx
