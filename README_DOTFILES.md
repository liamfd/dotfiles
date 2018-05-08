# clone this repo
git clone --bare https://github.com/liamfd/dotfiles.git $HOME/.cfg

#
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME' # add the `config` git alias
