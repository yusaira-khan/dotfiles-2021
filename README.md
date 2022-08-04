# Stow-ing and versioning dotfiles

## nulogy specific setup
```shell
stow --target=$HOME asdf-global git git-common intellij irb vim zsh
stow --target=$HOME/.config/direnv direnv
stow --target=$HOME/.byobu byobu
```

## home setup
```shell
stow --target=$HOME asdf-global git-home git-common irb vim zsh
stow --target=$HOME/.byobu byobu
```

## to initialize
```shell
mv ~/.file ~/.dotfiles/organized-dir/.file
cd ~/.dotfiles
stow --target=$HOME organized-dir
```

## todo
- regularly update intellimacs
