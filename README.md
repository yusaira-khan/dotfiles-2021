# Stow-ing and versioning dotfiles

## Work Setup
```shell
git submodule update --init --recursive
stow --target=$HOME git git-work asdf zsh vim intellij
mkdir -p $HOME/.config/direnv && stow --target=$HOME/.config/direnv direnv
```

## Home Setup
```shell
stow --target=$HOME git git-home asdf zsh vim spacemacs
stow --target=$HOME/.byobu byobu
```

## Initialize
To add file to the this repo (`$DOTFILES`), the following methods can be followed. Afterwards, the new file should be added to git.

### Using --adopt
```shell
cd $DOTFILES
mdkir organized-dir
touch organized-dir/.file
stow  --adopt --target=$HOME organized-dir
```

### Old Way
```shell
mv $HOME/.file $DOTFILES/organized-dir/.file
cd $DOTFILES
stow --target=$HOME organized-dir
```

## Conflict
If  `organized-dir/.file` is present in `$DOTFILES` and  `.file` in target (`$HOME`).
- follow the `--adopt` instructions. 
- use `git diff` to see the differences in git contents and file system contents

## todo
- regularly update git modules
