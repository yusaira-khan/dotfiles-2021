typeset -ga ls_options
ls_options+=( -G )
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



#a1# List files with colors (\kbd{ls \ldots})
alias ls="command ls ${ls_options:+${ls_options[*]}}"
#a1# List all files, with colors (\kbd{ls -la \ldots})
alias la="command ls -la ${ls_options:+${ls_options[*]}}"
#a1# List files with long colored list, without dotfiles (\kbd{ls -l \ldots})
alias ll="command ls -l ${ls_options:+${ls_options[*]}}"
#a1# List files with long colored list, human readable sizes (\kbd{ls -hAl \ldots})
alias lh="command ls -hAl ${ls_options:+${ls_options[*]}}"
#a1# List files with long colored list, append qualifier to filenames (\kbd{ls -l \ldots})\\&\quad(\kbd{/} for directories, \kbd{@} for symlinks ...)
alias l="command ls -l ${ls_options:+${ls_options[*]}}"
#a2# Only show dot-directories
alias lad='command ls -d .*(/)'
#a2# Only show dot-files
alias lsa='command ls -a .*(.)'
#a2# Display the ten biggest files
alias lsbig="command ls -flh *(.OL[1,10])"
alias lsnice="command ls -lSrah"
#a2# Display the ten newest files
alias lsnew="command ls -rtlh *(D.om[1,10])"
#a2# Display the ten oldest files
alias lsold="command ls -rtlh *(D.Om[1,10])"
#a2# Display the ten smallest files
alias lssmall="command ls -Srl *(.oL[1,10])"

#f5# Create Directory and \kbd{cd} to it
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

#f5# Create temporary directory and \kbd{cd} to it
function cdt () {
    builtin cd "$(mktemp -d)"
    builtin pwd
}

#f5# List files which have been accessed within the last {\it n} days, {\it n} defaults to 1
function accessed () {
    emulate -L zsh
    print -l -- *(a-${1:-1})
}

#f5# List files which have been changed within the last {\it n} days, {\it n} defaults to 1
function changed () {
    emulate -L zsh
    print -l -- *(c-${1:-1})
}


PS2='\`%_> '
# selection prompt used within a select loop.
PS3='?# '
# the execution trace prompt (setopt xtrace). default: '+%N:%i>'
PS4='+%N:%i:%_> '
