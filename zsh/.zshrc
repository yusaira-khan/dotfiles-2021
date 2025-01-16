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

# utilites for ruby playingaround
function seed_ruby() {

  cp -r ~/.tool-versions .
  SEED_DIR=~/.zsh-utilities/chunkys-dotfiles/.bin/.seed_ruby
  if [[ -d $SEED_DIR ]]; then
    cp $SEED_DIR/* .
    cp $SEED_DIR/.* .
    bundle
  fi
}


source $HOME/.zsh-utilities/misc.sh
source $HOME/.zsh-utilities/github.sh


#stuff from grml
source $HOME/.grml_utilities/primary.zsh
source $HOME/.grml_utilities/secondary.zsh
source $HOME/.grml_utilities/sll.zsh


if is_work ; then
  export PATH="/opt/homebrew/bin:$PATH"
  source $HOME/.zshrc.private
fi

export FZF_BASE=/usr/local/bin
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source $HOME/.zshrc.omz #oh my zshell

source $HOME/.zshrc.local #all relevant user env variables in this file

#installed utility initialization after all the zshrc local zshrc stuff is done
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

eval "$(direnv hook zsh)"
