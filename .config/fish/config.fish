fish_vi_key_bindings

# Set the cursor shapes for the different vi modes.
set fish_cursor_default     block      blink
set fish_cursor_insert      line       blink
set fish_cursor_replace_one underscore blink
set fish_cursor_visual      block

export EDITOR=vim

alias dotconf='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias q='exit'
