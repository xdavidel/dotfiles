#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

alias l='ls -lh --color=auto --group-directories-first'
alias ls='ls --color=auto --group-directories-first'
alias la='ls -A --color=auto --group-directories-first'
alias ll='ls -lAh --color=auto --group-directories-first'
alias dotconf='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
