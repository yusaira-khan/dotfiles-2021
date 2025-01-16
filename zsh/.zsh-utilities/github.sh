git_current_ticket_number () {
  git rev-parse --abbrev-ref HEAD | gsed -r '1s/^(.*-[[:digit:]]+)-.*/\1/'
}

git_current_branch_body () {
  git rev-parse --abbrev-ref HEAD | cut -d'-' -f 3- | sed -r 's/[-]+/ /g' | sed 's/.*/\u&/'
}

create_pr () {
  gh pr create --title "$(git_current_ticket_number): $(git_current_branch_body)"
}

view_pr () {
  gh pr view --web
}


branj_wrapper () {
  arg="$1"
  shift
  if [[ "$arg" == "*-*" ]]
    then command branj $arg "$@"
  else
    command branj "${DEFAULT_PROJECT:=CN1}-$arg" "$@"
  fi 
}
alias branj=branj_wrapper
