# dotfiles
This approach is based on https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/.

### Setup (new computer):
```sh
# in ~

# clone this repo
git clone --bare https://github.com/liamfd/dotfiles.git $HOME/.cfg

# add a temporary "config" alias to this git repo
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# copy the files
config checkout

# if there is a merge conflict, rename the conflicting files and try again
```

### Update

`config` is just an alias for this get repo. As such, you can use whichever git commands you'd like. For instance, to update the stored `.zshrc`:

```sh
config status
config add .zshrc
config commit -m "Updated .zshrc"
config push
```
