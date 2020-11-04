fish_vi_key_bindings

# get rid of greeting
set fish_greeting

# Set the cursor shapes for the different vi modes.
set fish_cursor_default     block      blink
set fish_cursor_insert      line       blink
set fish_cursor_replace_one underscore blink
set fish_cursor_visual      block

# Use neovim for vim if possible
type -q nvim && \
    alias vim="nvim" && \
    alias vimdiff="nvim -d"

# Colorize commands
alias l="ls -gGhF --color=auto --group-directories-first"
alias ls="ls -F --color=auto --group-directories-first"
alias la="ls -AF --color=auto --group-directories-first"
alias ll="ls -gGAFh --color=auto --group-directories-first"
alias grep="grep --color=auto"
alias diff="diff --color=auto"

# Command extensions
alias newsboat="newsboat && refbar news"
alias ffmpeg="ffmpeg -hide_banner"

# Shortcuts
alias ytv="youtube-dl --add-metadata -i -o '%(upload_date)s-%(title)s.%(ext)s'"
alias yta="youtube-dl -xi -f bestaudio/best --audio-format mp3"
alias dotconf="git --git-dir=$HOME/.local/dotfiles --work-tree=$HOME"

# abbr
abbr cp "cp -i"
abbr mv "mv -i"
abbr rm "rm -I"
abbr ka "killall"
abbr f "$FILE"
abbr e "$EDITOR"
abbr v "$EDITOR"
abbr q "exit"
abbr x "sxiv -ft *"
abbr .. "cd .."
abbr fr "manview ."
