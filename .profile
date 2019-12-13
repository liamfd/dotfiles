# env vars
export AWS_USER=liam

# NVM (assumes homebrew installation)

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# PYTHON

# Setting PATH for Python 3.6 (this doesn't appear to be required to get the aws cli working properly)
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH

# Get my path set up for Android studio / RN / Fastlane
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH="$PATH:$HOME/.fastlane/bin"

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

# ALIASES

# Git
alias glom='git pull origin master' # new
# alias gcam='git add .; git commit -m' # overridden, to include untracked files
alias gcam='echo "DO NOT COMMIT ALL, STAGE AND COMMIT INDIVIDUALLY"'
alias gcbom=git_checkout_branch_from_origin "master"
alias gcbo=git_checkout_branch_from_origin
alias grrb=git_rename_remote_branch

# render an interactive git branch picker sorted by most recent commit,
# and checkout the selection
alias gbrecent='git checkout $(git branch --sort=-committerdate | fzf)'

# override the zsh command with one that does not include the `git add -A`
alias gwip='git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify -m "--wip-- [skip ci]"'


# This adds the "dotfiles" alias, used for sharing my dotfiles (see README_DOTFILES.md)
alias dotfiles='/usr/bin/git --git-dir=/Users/liam/.cfg/ --work-tree=/Users/liam'