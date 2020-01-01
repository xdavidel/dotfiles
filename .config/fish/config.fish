fish_vi_key_bindings

# Set the cursor shapes for the different vi modes.
set fish_cursor_default     block      blink
set fish_cursor_insert      line       blink
set fish_cursor_replace_one underscore blink
set fish_cursor_visual      block

export EDITOR=vim

alias dotconf='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias q='exit'
alias ka="killall"
alias calcurse="calcurse -D ~/.config/calcurse"
alias f="$FILE"
alias e="$EDITOR"
alias v="$EDITOR"
alias q="exit"
alias x="sxiv -ft *"
alias ytv="youtube-dl --add-metadata -i -o '%(upload_date)s-%(title)s.%(ext)s'"
alias yta="youtube-dl -xi --audio-format mp3"
alias l="ls -gGhF --color=auto --group-directories-first"
alias ls="ls -F --color=auto --group-directories-first"
alias la="ls -AF --color=auto --group-directories-first"
alias ll="ls -gGAFh --color=auto --group-directories-first"
alias dotconf="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias grep="grep --color=auto"
alias ffmpeg="ffmpeg -hide_banner"

if type -q nvim
	alias vim="nvim"
	alias vimdiff="nvim -d" # Use neovim for vim if possible
end

function vf
	fzf | xargs -r - I % $EDITOR %
end

