# Stow-ing and versioning dotfiles

## nulogy specific setup
```shell
stow asdf-global byobu git  git-common intellij irb vim zsh
```

## home setup
```shell
stow asdf-global byobu git  git-common intellij irb vim zsh
```

## to initialize
```shell
mv ~/.stuff ~/.dotfiles/<organized-dir>/.stuff
cd ~/.dotfiles
stow <organized-dir>
```

## todo
- regularly update intellimacs
