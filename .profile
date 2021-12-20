# env vars
export AWS_USER=liam
export AWS_PROFILE=orgs_admin

# NVM (assumes homebrew installation)

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# PYTHON

# Setting PATH to support `pip3 install awscli --upgrade --user`
# see https://docs.aws.amazon.com/cli/latest/userguide/install-macos.html#awscli-install-osx-path
PATH="${HOME}/Library/Python/3.6/bin:${PATH}"
export PATH

# Get my path set up for Android studio / RN / Fastlane
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH="$PATH:$HOME/.fastlane/bin"

# Rust
source "$HOME/.cargo/env"

# FUNCTIONS

git_checkout_branch_from_origin()
{
  REMOTE_BRANCH_NAME=$1 # string
  LOCAL_BRANCH_NAME=$2 # ?string

  git fetch

  if [ $LOCAL_BRANCH_NAME ]
  then
    # if we have LOCAL_BRANCH_NAME, treat it as a totally separate branch
    git checkout -b $LOCAL_BRANCH_NAME origin/$REMOTE_BRANCH_NAME --no-track
  else
    # otherwise, just make a local copy
    git checkout -b $REMOTE_BRANCH_NAME origin/$REMOTE_BRANCH_NAME
  fi
}

git_rename_remote_branch()
{
  NEW_NAME=$1

  # get current branch name, throw if in detached HEAD state
  CURR_NAME="$(git symbolic-ref --short HEAD)"

  git branch -m $NEW_NAME
  git push origin :$CURR_NAME $NEW_NAME
  git push origin -u $NEW_NAME
}

# create fixup commit and launch interactive rebase to apply it
# pairs well with `glfhash` below
git_fixup_rebase_autosquash()
{
  git commit --fixup $1
  git rebase -i $1~ --autosquash
}

jq_format_file()
{
  FILE_PATH=$1

  echo "$(jq . $FILE_PATH)" > $FILE_PATH
}

# create a file with intermediate directories as needed
touch_p()
{
  FILE_PATH=$1
  DIR_PATH=$(dirname $FILE_PATH)

  mkdir -p $DIR_PATH
  touch $FILE_PATH
}

# ALIASES

# Git
alias glom='git pull origin master' # new
# alias gcam='git add .; git commit -m' # overridden, to include untracked files
alias gcam='echo "DO NOT COMMIT ALL, STAGE AND COMMIT INDIVIDUALLY"'
alias gcbom='git_checkout_branch_from_origin master'
alias gcbo=git_checkout_branch_from_origin
alias grrb=git_rename_remote_branch
alias gfix="git commit --fixup"
alias gfixra=git_fixup_rebase_autosquash

# render an interactive git branch picker sorted by most recent commit
alias gbrecent='git branch --sort=-committerdate | fzf'

# override the zsh alias with one that does not include the `git add -A`
alias gwip='git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify -m "--wip-- [skip ci]"'

# interactively choose a commit hash from the last 30 in the log
alias glfhash="git log --oneline -n 30 | fzf --no-sort | awk '{print \$1}'"

# see jq_format_file
alias format_json_file=jq_format_file

# see touch_p
alias touchp=touch_p

# get a histogram unique lines
alias histog="sort -n | uniq -c | sort -nr"

# This adds the "dotfiles" alias, used for sharing my dotfiles (see README_DOTFILES.md)
alias dotfiles='/usr/bin/git --git-dir=/Users/liam/.cfg/ --work-tree=/Users/liam'

# Fabric custom aliases
alias use-orgs='bash /Users/liam/fabric/linen/tools/use-orgs.sh; export AWS_PROFILE=orgs_admin'
alias use-og='bash /Users/liam/fabric/linen/tools/use-og.sh; unset AWS_PROFILE'
