# Enable colors and change prompt:
autoload -U colors && colors

_prompt_init() {
	# time format string
	: ${PROMPT_TIMEFMT="%*"}

	# multi-line prompt?
	tempv=$'\n'
	: ${PROMPT_MULTILINE=$tempv}
	unset tempv

    # color used for matching characters
	: ${PROMPT_WRAPCOL="%F{magenta}"}

	# red when shell is escalated, cyan otherwise
	: ${PROMPT_USERCOL="%(!,%F{red},%F{cyan})"}

	# red exit code when the last command exits non-zero
	: ${PROMPT_ECODE="%(?,,%F{red}%?)"}

	# when running as root and the user format wasn't defined, show the username
	[[ $(whoami) == 'root' && -z $PROMPT_USER_FMT ]] && PROMPT_USER_FMT=" %n "

	# define some nice characters
	: ${PROMPT_ARROW=">"}
	: ${PROMPT_LNBR1="┌"}
	: ${PROMPT_LNBR2="└"}

	# and colorize them
    PROMPT_ARROW="${PROMPT_WRAPCOL}${PROMPT_ARROW}%f"
    PROMPT_LNBR1="${PROMPT_WRAPCOL}${PROMPT_LNBR1}%f"
    PROMPT_LNBR2="${PROMPT_WRAPCOL}${PROMPT_LNBR2}%f"
}

_prompt_time() {
    (( (${COLUMNS:-$(tput cols)} / 4) / 4 > 2 )) && echo -ne " $PROMPT_TIMEFMT"
}

_prompt_dir() {
	if [[ -z $PROMPT_MULTILINE ]]; then
		(( ${COLUMNS:-$(tput cols)} > 60 )) && echo -ne "%-45<...<%~%<<" || echo -ne "..%1~"
    else
        echo -ne "%-2<...<%~%<<"
    fi
}

_prompt_precmd_title() {
	echo -ne "\e]2;$USER@zsh - $PWD\a"
}

_prompt_preexec_title() {
	echo -ne "\e]2;$USER@zsh - $PWD: " && echo -ne "${(q)1}\a"
}

# load the default values used in the prompt
_prompt_init

# add hook functions
if [[ $TERM =~ (xterm|rxvt|st) ]]; then
	precmd_functions+=(_prompt_precmd_title)
	preexec_functions+=(_prompt_preexec_title)
fi

# set the prompts
PROMPT="${PROMPT_LNBR1}${PROMPT_ECODE}${PROMPT_USERCOL} "
PROMPT+="${PROMPT_WRAPCOL}$(_prompt_dir)${PROMPT_MULTILINE}"
PROMPT+="${PROMPT_LNBR2}${PROMPT_ARROW} %#%f "

# init the right prompt
RPROMPT=""

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# reduce system calls for timezone
typeset -gx TZ=:/etc/localtime

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# key bindings
bindkey "\e[3~" delete-char
bindkey "^?"	backward-delete-char
bindkey  "^[[H" beginning-of-line
bindkey  "^[[F" end-of-line

# keymap changed binding
function zle-keymap-select zle-line-init {
	if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
		echo -ne '\e[1 q'
		RPROMPT="$(_prompt_time) %{$bg[red]%}[N]%{$reset_color%}"
    elif [[ ${KEYMAP} == main ]] ||
         [[ ${KEYMAP} == viins ]] ||
         [[ ${KEYMAP} = '' ]] ||
         [[ $1 = 'beam' ]]; then
		echo -ne '\e[5 q'
		RPROMPT="$(_prompt_time) %{$bg[green]%}[I]%{$reset_color%}"
	fi
	zle reset-prompt
}

zle -N zle-keymap-select
zle -N zle-line-init

# Use beam shape cursor for each new prompt.
preexec() { echo -ne '\e[0m\e[5 q' ;}

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
	tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
	    dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Configs alias
alias dotconf='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# Load aliases and shortcuts if existent.
[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
