#f2# Find history events by search pattern and list them by date.
function whatwhen () {
    emulate -L zsh
    local usage help ident format_l format_s first_char remain first last
    usage='USAGE: whatwhen [options] <searchstring> <search range>'
    help='Use `whatwhen -h'\'' for further explanations.'
    ident=${(l,${#${:-Usage: }},, ,)}
    format_l="${ident}%s\t\t\t%s\n"
    format_s="${format_l//(\\t)##/\\t}"
    # Make the first char of the word to search for case
    # insensitive; e.g. [aA]
    first_char=[${(L)1[1]}${(U)1[1]}]
    remain=${1[2,-1]}
    # Default search range is `-100'.
    first=${2:-\-100}
    # Optional, just used for `<first> <last>' given.
    last=$3
    case $1 in
        ("")
            printf '%s\n\n' 'ERROR: No search string specified. Aborting.'
            printf '%s\n%s\n\n' ${usage} ${help} && return 1
        ;;
        (-h)
            printf '%s\n\n' ${usage}
            print 'OPTIONS:'
            printf $format_l '-h' 'show help text'
            print '\f'
            print 'SEARCH RANGE:'
            printf $format_l "'0'" 'the whole history,'
            printf $format_l '-<n>' 'offset to the current history number; (default: -100)'
            printf $format_s '<[-]first> [<last>]' 'just searching within a give range'
            printf '\n%s\n' 'EXAMPLES:'
            printf ${format_l/(\\t)/} 'whatwhen grml' '# Range is set to -100 by default.'
            printf $format_l 'whatwhen zsh -250'
            printf $format_l 'whatwhen foo 1 99'
        ;;
        (\?)
            printf '%s\n%s\n\n' ${usage} ${help} && return 1
        ;;
        (*)
            # -l list results on stout rather than invoking $EDITOR.
            # -i Print dates as in YYYY-MM-DD.
            # -m Search for a - quoted - pattern within the history.
            fc -li -m "*${first_char}${remain}*" $first $last
        ;;
    esac
}