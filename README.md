# Stow-ing and versioning dotfiles

## nulogy specific setup
```shell
stow --target=~ asdf-global byobu git git-common intellij irb vim zsh
stow --target=~/.config/direnv direnv
```

## home setup
```shell
stow asdf-global byobu git-home git-common irb vim zsh
```

## to initialize
```shell
mv ~/.file ~/.dotfiles/organized-dir/.file
cd ~/.dotfiles
stow --target=~ organized-dir
```

## todo
- regularly update intellimacs
