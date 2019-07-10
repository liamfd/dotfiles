# dotfiles
This approach is based on https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/.

### Setup (new computer):
```sh
# in ~

# clone this repo
git clone --bare https://github.com/liamfd/dotfiles.git $HOME/.cfg

# add a temporary "dotfiles" alias to this git repo
alias dotfiles='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# copy the files
dotfiles checkout

# ignore untracked (non dotfiles) files
dotfiles config --local status.showUntrackedFiles no

# if there is a merge conflict, rename the conflicting files and try again
```

### Dependencies
- [jq](https://stedolan.github.io/jq/)

*Install*:
```
brew install jq
```

*Usage*:
```
aws dynamodb get-item --table-name liam-Application --key "$(jq -n '{appId: {N: "5001847"}}')"
```


### Update

`dotfiles` is just an alias for this git repo. As such, you can use whichever git commands you'd like. For instance, to update the stored `.zshrc`:

```sh
dotfiles status
dotfiles add .zshrc
dotfiles commit -m "Updated .zshrc"
dotfiles add -u # add only tracked files, ignores everything else in ~
dotfiles commit -m "Updated everything"
dotfiles push
```
