typeset -ga ls_options
ls_options+=( -v )
export CLICOLOR=1
REPORTTIME=5



setopt append_history
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt noshwordsplit
setopt interactivecomments
setopt print_exit_value


# grep for running process, like: 'any vim'
function any () {
    emulate -L zsh
    unsetopt KSH_ARRAYS
    if [[ -z "$1" ]] ; then
        echo "any - grep for process(es) by keyword" >&2
        echo "Usage: any <keyword>" >&2 ; return 1
    else
        ps xauwww | grep -i "${grep_options[@]}" "[${1[1]}]${1[2,-1]}"
    fi
}

#f5# cd to directory and list files
function cl () {
    emulate -L zsh
    cd $1 && ls -a
}


#List files with colors ls [...])
alias ls="command lsd ${ls_options:+${ls_options[*]}}"
# List all files, with colors ls [...])
alias la="command lsd -la ${ls_options:+${ls_options[*]}}"
#List files with long colored list, without dotfiles ls -l [...])
alias ll="command lsd -l ${ls_options:+${ls_options[*]}}"
# List files with long colored list, human readable sizes ls -hAl [...])
alias lh="command lsd -hAl ${ls_options:+${ls_options[*]}}"
# List files with long colored list, append qualifier to filenames ls -l [...]. / for directories, @ for symlinks
alias l="command lsd -l ${ls_options:+${ls_options[*]}}"
# Only show dot-directories
alias lsdotdir='command lsd -d .*(/)'
# Only show dot-files
alias lsdotfiles='command lsd -a .*(.)'
# Display the ten biggest files
alias lsbig="command lsd -flh *(.OL[1,10])"
alias lsnice="command lsd -lSrah"
# Display the ten newest files
alias lsnew="command lsd -rtlh *(D.om[1,10])"
# Display the ten oldest files
alias lsold="command lsd -rtlh *(D.Om[1,10])"
# Display the ten smallest files
alias lssmall="command lsd -Srl *(.oL[1,10])"

# Create Directory and cd to it
function mkcd () {
    if (( ARGC != 1 )); then
        printf 'usage: mkcd <new-directory>\n'
        return 1;
    fi
    if [[ ! -d "$1" ]]; then
        command mkdir -p "$1"
    else
        printf '`%s'\'' already exists: cd-ing.\n' "$1"
    fi
    builtin cd "$1"
}

# Create temporary directory and cd to it
function cdt () {
    builtin cd "$(mktemp -d)"
    builtin pwd
}

#List files which have been accessed within the last  n days,  n defaults to 1
function accessed () {
    emulate -L zsh
    print -l -- *(a-${1:-1})
}

# List files which have been changed within the last  n days, n defaults to 1
function changed () {
    emulate -L zsh
    print -l -- *(c-${1:-1})
}
