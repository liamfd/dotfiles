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

#### Setup - Other packages

1. [Install `homebrew`](https://brew.sh/)
2. Setup oh-my-zsh and plugins

    ```bash
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/    zsh-syntax-highlighting
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    ```

    Additionally, [install + configure the powerlevel10k fonts](https://github.com/romkatv/powerlevel10k#fonts), you'll want to support both iterm and vscode.

3. Install some useful command line utils:

    ```bash
    brew install gh tree ag jq fzf diff-so-fancy
    ```

    `diff-so-fancy` requires some [additional setup](https://github.com/so-fancy/diff-so-fancy#with-git) to use with other command line tools.

4. Install some other programs you like:

    ```bash
    brew install --cask iterm2 visual-studio-code spotify
    ```

5. Install some programming environment things:

    1. [Install NVM](https://github.com/nvm-sh/nvm)

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
