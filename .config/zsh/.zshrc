## Options section
unsetopt PROMPT_SP        # Don't ttempt to preserve a partial line
unsetopt nomatch          # Passes the command as is instead of reporting pattern matching failure
setopt rcexpandparam      # Array expension with parameters
setopt nocheckjobs        # Don't warn about running processes when exiting
setopt numericglobsort    # Sort filenames numerically when it makes sense
setopt nobeep             # No beep
setopt appendhistory      # Immediately append history instead of overwriting
setopt histignorealldups  # If a new command is a duplicate, remove the older one

autoload -U compinit colors
compinit
colors

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'   # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"     # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                          # Automatically find new executables in path

# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zsh/cache

HISTFILE=~/.cache/zsh/history
HISTSIZE=10000
SAVEHIST=10000
WORDCHARS=${WORDCHARS//\/[&.;]}                             # Don't consider certain characters part of the word
GIT_COLORS=0

## Keybindings section
# vi mode
bindkey -v
export KEYTIMEOUT=1

bindkey '^[[7~'   beginning-of-line                         # Home key
bindkey '^[[H'    beginning-of-line                         # Home key
bindkey '^[[8~'   end-of-line                               # End key
bindkey '^[[F'    end-of-line                               # End key
bindkey '^[[2~'   overwrite-mode                            # Insert key
bindkey '^[[3~'   delete-char                               # Delete key
bindkey '^?'      backward-delete-char                      # Delete key
bindkey '^[[C'    forward-char                              # Right key
bindkey '^[[D'    backward-char                             # Left key
bindkey '\e[A'    history-search-backward                   # Page up key
bindkey '\e[B'    history-search-forward                    # Page down key
bindkey '^[[5~'   history-beginning-search-backward         # Page up key
bindkey '^[[6~'   history-beginning-search-forward          # Page down key

# Navigate words with ctrl+arrow keys
bindkey '^[Oc'    forward-word                              # Ctrl + Right key
bindkey '^[Od'    backward-word                             # Ctrl + Left key
bindkey '^H'      backward-kill-word                        # delete previous word with ctrl+backspace
bindkey '^[[Z'    undo                                      # Shift+tab undo last action

NEWLINE=$'\n'

# display git status in prompt
function git_status {
    local statc="%{%b%f%}" # assume none
    local bname="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"

    if [ -n "$bname" ]; then
        if [ "$GIT_COLORS" == 1 ]; then
            local rs="$(git status --porcelain -b 2>/dev/null)"
            if $(echo "$rs" | grep -v '^##' &> /dev/null); then # is dirty
                statc="%{%F{red}%B%}"
            elif $(echo "$rs" | grep '^## .*diverged' &> /dev/null); then # has diverged
                statc="%{%F{red}%B%}"
            elif $(echo "$rs" | grep '^## .*behind' &> /dev/null); then # is behind
                statc="%{%F{cyan}%B%}"
            elif $(echo "$rs" | grep '^## .*ahead' &> /dev/null); then # is ahead
                statc="%{%F{cyan}%B%}"
            else # is clean
                statc="%{%F{green}%B%}"
            fi
        fi
        echo -n "$statc($bname)%{%b%f%}"
    fi
}

# keymap changed binding
function zle-keymap-select zle-line-init {
    if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
        echo -ne '\e[1 q'
        VIMODE="%{$bg[red]%}%B[N]%b"
    elif [[ ${KEYMAP} == main ]] ||
        [[ ${KEYMAP} == viins ]] ||
        [[ ${KEYMAP} = '' ]] ||
        [[ $1 = 'beam' ]]; then
        echo -ne '\e[5 q'
        VIMODE="%{$bg[green]%}%B[I]%b"
    fi

    if [[ -n ${VIRTUAL_ENV} ]]; then
        VENV="%F{cyan} (venv)"
    else
        VENV=""
    fi

    PROMPT="%B%F{red}[%F{yellow}%n%F{green}@%F{blue}%M%F{red}]${VENV}%}%F{magenta} ${PWD/#$HOME/~}%{%b%f%} $(git_status)${NEWLINE}${VIMODE}%{$reset_color%} %% "
    zle reset-prompt
}

zle -N zle-keymap-select
zle -N zle-line-init

# Use beam shape cursor for each new prompt.
preexec() { echo -ne '\e[0m\e[5 q' ;}

# Use lf to switch directories
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

# use vifm to switch directories
vifmcd () {
    tmp="$(mktemp)"
    vifm --choose-dir "$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

gclrs () {
    [ "$GIT_COLORS" == 0 ] && GIT_COLORS=1 || GIT_COLORS=0
}

# bind ctrl-o to switch directories using file manager
bindkey -s '^o' 'lfcd\n'

# bind ctrl-a to open calculator
bindkey -s '^a' 'bc -lq\n'

# bind ctrl-f to fuzzy open folders
bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'

# bind ctrl-g to toggle git colors
bindkey -s '^g' 'gclrs\n'

# Print a greeting message when shell is started
#echo $USER@$HOST  $(uname -srm) $(lsb_release -rcs)

## Prompt on right side:

# Right prompt with time and exit status of previous command marked with ✓ or ✗
# RPROMPT="%(?.%{$fg[green]%}[OK].%{$fg[red]%}[%?])%{$reset_color%} %{$fg[yellow]%}%*"
RPROMPT="%(?..%{$fg[red]%}[%?])%{$reset_color%} %{$fg[yellow]%}%*%{$reset_color%}"

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Configs git completions
compdef dotconf="git"

# Load aliases and shortcuts if existent.
[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

# Load zsh plugins
[ -f "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && source "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
[ -f "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && source "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
