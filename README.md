# dotfiles

This is based on [a bare repository approach](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/).

To get started: 
```sh
# clone this repo
git clone --bare https://github.com/liamfd/dotfiles.git $HOME/.cfg

# 
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME' # add the `config` git alias
```
