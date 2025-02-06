git_current_ticket_number () {
  git rev-parse --abbrev-ref HEAD | gsed -r '1s/^(.*-[[:digit:]]+)-.*/\1/'
}

git_current_branch_body () {
  git rev-parse --abbrev-ref HEAD | cut -d'-' -f 3- | gsed -r 's/[-]+/ /g' | gsed 's/.*/\u&/'
}

create_pr () {
  set -x
  s_flag=""
  s_arg=""
  if [[ -f pull_request_template.md ]]; then
    s_flag="-F"
    s_arg=pull_request_template.md
  else
    s_flag="--body"
    s_arg=""
  fi

  gh pr create --title "$(git_current_ticket_number): $(git_current_branch_body)" $s_flag "$s_arg"
  set +x
}

view_pr () {
  gh pr view --web
}


branj_wrapper () {
  arg="$1"
  shift
  if [[ "$arg" == "*-*" ]]
    then branj $arg "$@"
  else
    branj "${DEFAULT_PROJECT:=CN1}-$arg" "$@"
  fi 
}
alias branjw=branj_wrapper
