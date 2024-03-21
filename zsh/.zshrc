function is_homelenovo() {
  if [[ -f $HOME/.wsl-lenovo ]]; then
    return 0
  else
    return 1
  fi
}

function is_work() {
  if is_homelenovo; then
    return 1
  else
    return 0
  fi
}

function is_intellij() {
  if [[ ${__CFBundleIdentifier:-"unknown"} == *jetbrains* ]]
  then
    return 0
  else
    return 1
  fi
}

alias grep="command rg"
alias ripgrep="command rg"

#stuff from grml
source $HOME/.grml_utilities/primary.zsh
source $HOME/.grml_utilities/secondary.zsh
source $HOME/.grml_utilities/simple_extract.zsh
source $HOME/.grml_utilities/sll.zsh


export FZF_BASE=/usr/local/bin
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source $HOME/.zshrc.omz #oh my zshell

source $HOME/.zshrc.local #all relevant user env variables in this file

#installed utility initialization after all the zshrc local zshrc stuff is done
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

if is_work ; then
  source $HOME/.zshrc.private
fi

function border() {
  echo "----------------------------------"
  echo
}

function docker_clean() {
  echo "Stopping the following containers:"
  docker ps
  docker stop $(docker ps -q)
  border

  echo "Removing the following containers:"
  docker ps -a
  docker rm $(docker ps -a -q)
  border

  echo "Removing volumes"
  docker volume rm $(docker volume ls -q)
  border

  echo "Pruning System"
  docker system prune -f
  border
}


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
function conda_setup() {
__conda_setup="$('/home/yusairak/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/yusairak/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/yusairak/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/yusairak/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
}
eval "$(direnv hook zsh)"
