typeset -ga ls_options
ls_options+=( -v )
export CLICOLOR=1
REPORTTIME=5

# append history list to the history file; this is the default but we make sure
# because it's required for share_history.
setopt append_history

# import new commands from the history file also in other zsh-session
setopt share_history

# save each command's beginning timestamp and the duration to the history file
setopt extended_history

# If a new command line being added to the history list duplicates an older
# one, the older command is removed from the list
setopt histignorealldups

# NOT USING: if a command is issued that can't be executed as a normal command, and the
# command is the name of a directory, perform the cd command to that directory.
#setopt auto_cd

# make cd push the old directory onto the directory stack.
setopt auto_pushd

# don't push the same dir twice.
setopt pushd_ignore_dups

# use zsh style word splitting
setopt noshwordsplit

# allow comments in interactive terminals
setopt interactivecomments

setopt print_exit_value

# whenever a command completion is attempted, make sure the entire command path
# is hashed first.
setopt hash_list_all

# not just at the end
setopt completeinword


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


# listing stuff
# Execute \kbd{ls -lSrah}
alias dir="command ls -lSrah"
# Only show dot-directories
alias lad='command ls -d .*(/)'
# Only show dot-files
alias lsa='command ls -a .*(.)'
# Only files with setgid/setuid/sticky flag
alias lss='command ls -l *(s,S,t)'
# Only show symlinks
alias lsl='command ls -l *(@)'
# Display only executables
alias lsx='command ls -l *(*)'
# Display world-{readable,writable,executable} files
alias lsw='command ls -ld *(R,W,X.^ND/)'
# Display the ten biggest files
alias lsbig="command ls -flh *(.OL[1,10])"
# Only show directories
alias lsd='command ls -d *(/)'
# Only show empty directories
alias lse='command ls -d *(/^F)'
# Display the ten newest files
alias lsnew="command ls -rtlh *(D.om[1,10])"
# Display the ten oldest files
alias lsold="command ls -rtlh *(D.Om[1,10])"
# Display the ten smallest files
alias lssmall="command ls -Srl *(.oL[1,10])"
# Display the ten newest directories and ten newest .directories
alias lsnewdir="command ls -rthdl *(/om[1,10]) .*(D/om[1,10])"
# Display the ten oldest directories and ten oldest .directories
alias lsolddir="command ls -rthdl *(/Om[1,10]) .*(D/Om[1,10])"

# Remove current empty directory. Execute \kbd{cd ..; rmdir \$OLDCWD}
alias rmcdir='cd ..; rmdir $OLDPWD || cd $OLDPWD'
alias ...='cd ../../'

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
