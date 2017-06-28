HISTFILE=~/.histfile
HISTSIZE=50000
SAVEHIST=50000
setopt appendhistory autocd extendedglob nomatch notify completealiases
unsetopt beep
bindkey -e

# Vars used later on by Zsh
export EDITOR="vim"
export BROWSER=firefox
export MANPAGER="/usr/bin/less"

##################################################################
# Stuff to make my life easier

# allow approximate
zstyle ':completion:*' completer _complete _match _approximate 
zstyle ':completion:*' menu select
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# tab completion for PID :D
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

# cd not select parent dir
zstyle ':completion:*:cd:*' ignore-parents parent pwd


##################################################################
# My aliases

# Set up auto extension stuff
alias -s html=$BROWSER
alias -s org=$BROWSER
alias -s php=$BROWSER
alias -s com=$BROWSER
alias -s net=$BROWSER
alias -s png=feh
alias -s jpg=feh
alias -s gif=feg
alias -s sxw=soffice
alias -s doc=soffice
alias -s gz='tar -xzvf'
alias -s bz2='tar -xjvf'
alias -s java=$EDITOR
alias -s txt=$EDITOR
alias -s PKGBUILD=$EDITOR

# Normal aliases
alias ls='ls --color=auto -F'
alias ll='ls -larth'
alias l='ls -aF'
alias grep='grep --exclude="*.svn*" --exclude="*.git*" -sI --color=auto'
alias du='du -h'
alias df='df -h'
alias mem="free -m"

alias ssh='TERM=rxvt ssh'
alias git-root='cd $(git rev-parse --show-cdup)'
if [ -f /usr/share/autojump/autojump.sh ]; then
    . /usr/share/autojump/autojump.sh
fi
alias vim-basic='vim ~/.vim/config/basic.vim'
alias vim-extended='vim ~/.vim/config/extended.vim'
alias vim-filetypes='vim ~/.vim/config/filetypes.vim'
alias vim-plugins='vim ~/.vim/config/plugins_config.vim'


man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
        LESS_TERMCAP_md=$'\E[01;38;5;74m' \
        LESS_TERMCAP_me=$'\E[0m' \
        LESS_TERMCAP_se=$'\E[0m' \
        LESS_TERMCAP_so=$'\E[38;5;246m' \
        LESS_TERMCAP_ue=$'\E[0m' \
        LESS_TERMCAP_us=$'\E[04;38;5;146m' \
        man "$@"
}

##################################################################
# Binding

# for rxvt
bindkey "\e[7~" beginning-of-line # Home
bindkey "\e[8~" end-of-line # End
bindkey "^[^[[D" backward-word
bindkey "^[^[[C" forward-word


# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

function precmd {
local TERMWIDTH
(( TERMWIDTH = ${COLUMNS} - 1 ))
###
# Truncate the path if it's too long.

PR_FILLBAR=""
PR_PWDLEN=""

local promptsize=${#${(%):---(%n@%m:%l)---()--}}
local pwdsize=${#${(%):-%~}}

if [[ "$promptsize + $pwdsize" -gt $TERMWIDTH ]]; then
    ((PR_PWDLEN=$TERMWIDTH - $promptsize))
else
    PR_FILLBAR="\${(l.(($TERMWIDTH - ($promptsize + $pwdsize)))..${PR_HBAR}.)}"
fi

###
# Get APM info.

if which ibam > /dev/null; then
    PR_APM_RESULT=`ibam --percentbattery`
elif which apm > /dev/null; then
    PR_APM_RESULT=`apm`
fi

}

setopt extended_glob
preexec () {
    if [[ $term == screen* ]]; then
        local cmd=${1[(wr)^(*=*|sudo|-*)]}
        echo -ne "\ek$cmd\e\\"
    fi
    print -Pn "\e]0;%~ ($1)\a"
}


setprompt () {
    ###
    # Need this so the prompt will work.

    setopt prompt_subst
    #autoload -Uz vcs_info
    #zstyle ':vcs_info:*' actionformats \
    #        '-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
    #zstyle ':vcs_info:*' formats       \
    #        '%F{3} %F{4}[%F{2}%b%F{4}]%f'
    #zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

    #zstyle ':vcs_info:*' enable git cvs svn

   # or use pre_cmd, see man zshcontrib
    #vcs_info_wrapper() {
    #    vcs_info
    #    if [ -n "$vcs_info_msg_0_" ]; then
    #        echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
    #    fi
   #}


    ###
    # See if we can use colors.

    autoload colors zsh/terminfo
    if [[ "$terminfo[colors]" -ge 8 ]]; then
        colors
    fi
    for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
        eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
        eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
        (( count = $count + 1 ))
    done
    PR_NO_COLOUR="%{$terminfo[sgr0]%}"


    ###
    # See if we can use extended characters to look nicer.

    typeset -A altchar
    set -A altchar ${(s..)terminfo[acsc]}
    PR_SET_CHARSET="%{$terminfo[enacs]%}"
    PR_SHIFT_IN="%{$terminfo[smacs]%}"
    PR_SHIFT_OUT="%{$terminfo[rmacs]%}"
    PR_HBAR=${altchar[q]:--}
    PR_ULCORNER=${altchar[l]:--}
    PR_LLCORNER=${altchar[m]:--}
    PR_LRCORNER=${altchar[j]:--}
    PR_URCORNER=${altchar[k]:--}


    ###
    # Decide if we need to set titlebar text.

    case $TERM in
        xterm*)
            PR_TITLEBAR=$'%{\e]0;%n@%m:%~ | ${COLUMNS}x${LINES} | %y\a%}'
            ;;
        screen*)
            PR_TITLEBAR=$'%{\e_#\005n (\005t) | %(!.ROOT | .)%n@%m:%~ | %y\e\\%}'
            ;;
        rxvt*)
            PR_TITLEBAR=$'%{\e]0;%(!.ROOT | .)%n@%m:%~ | %y\a%}'
            ;;
        *)
            PR_TITLEBAR=''
            ;;
    esac


    ###
    # Decide whether to set a screen title
    if [[ $TERM == screen* ]]; then
        PR_STITLE=$'%{\ekzsh\e\\%}'
    else 
        PR_STITLE=''
    fi

    ###
    # Finally, the prompt.

    PROMPT='$PR_SET_CHARSET$PR_RED%(!.%SROOT%s.)$PR_BLUE%m$PR_BLUE$PR_SHIFT_IN$PR_HBAR%(?..$PR_RED%?$PR_NO_COLOUR)$PR_SHIFT_OUT$PR_BLUE>$PR_NO_COLOUR '
    RPROMPT=' $PR_RED(%$PR_PWDLEN<...<%~%<<$PR_RED)$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT$PR_NO_COLOUR'
}

setprompt


