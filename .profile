# PYTHON
# Setting PATH to support `pip3 install awscli --upgrade --user`
# see https://docs.aws.amazon.com/cli/latest/userguide/install-macos.html#awscli-install-osx-path
PATH="${HOME}/Library/Python/3.6/bin:${PATH}"
export PATH

# Get my path set up for Android studio / RN / Fastlane
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-11.jdk/Contents/Home
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Rust
# source "$HOME/.cargo/env"

# FUNCTIONS

git_checkout_branch_from_origin() {
  REMOTE_BRANCH_NAME=$1 # string
  LOCAL_BRANCH_NAME=$2  # ?string

  git fetch

  if [ $LOCAL_BRANCH_NAME ]; then
    # if we have LOCAL_BRANCH_NAME, treat it as a totally separate branch
    git checkout -b $LOCAL_BRANCH_NAME origin/$REMOTE_BRANCH_NAME --no-track
  else
    # otherwise, just make a local copy
    git checkout -b $REMOTE_BRANCH_NAME origin/$REMOTE_BRANCH_NAME
  fi
}

git_rename_remote_branch() {
  NEW_NAME=$1

  # get current branch name, throw if in detached HEAD state
  CURR_NAME="$(git symbolic-ref --short HEAD)"

  git branch -m $NEW_NAME
  git push origin :$CURR_NAME $NEW_NAME
  git push origin -u $NEW_NAME
}

# create fixup commit and launch interactive rebase to apply it
# pairs well with `glfhash` below
git_fixup_rebase_autosquash() {
  git commit --fixup $1
  git rebase -i $1~ --autosquash
}

jq_format_file() {
  FILE_PATH=$1

  echo "$(jq . $FILE_PATH)" >$FILE_PATH
}

# create a file with intermediate directories as needed
touch_p() {
  FILE_PATH=$1
  DIR_PATH=$(dirname $FILE_PATH)

  mkdir -p $DIR_PATH
  touch $FILE_PATH
}

# create a file with intermediate directories as needed
file_with_intermediate() {
  git checkout -b
  DIR_PATH=$(dirname $FILE_PATH)

  mkdir -p $DIR_PATH
  touch $FILE_PATH
}

git_add_patch_and_commit() {
  git add --patch "$@"
  git commit
}

# open the current PR in the browser. If it doesn't exist, create it then open.
go_to_gh_pr() {
  gh pr view -w || (gh pr create -d && gh pr view -w)
}

# https://gist.github.com/hlissner/db74d23fc00bed81ff62
global_find_replace() {
  ag -0 -l $1 | xargs -0 perl -pi.bak -e "s/$1/$2/g"
}

diff_fancy_unified() {
  diff -u "$1" "$2" | diff-so-fancy
}

diff_fancy_unified_json() {
  JQ_PATH=${3:-.} # optional third arg to define the path to compare

  # sorting the keys reduces false positives in the diff output
  diff_fancy_unified <(jq --sort-keys $JQ_PATH "$1") <(jq --sort-keys $JQ_PATH "$2")
}

# ALIASES
# use https://github.com/eza-community/eza for ls
alias ls=eza

# Git
alias gllo='git log --pretty=format:"%h%x09%x09%ad%x09%s"'
alias glom='git pull origin master'
# alias gcam='git add .; git commit -m' # overridden, to include untracked files
alias gcam='echo "DO NOT COMMIT ALL, STAGE AND COMMIT INDIVIDUALLY"'
alias gcbo='git_checkout_branch_from_origin'
alias gcbom='git_checkout_branch_from_origin master'
alias grrb=git_rename_remote_branch
alias gfix="git commit --fixup"
alias gfixra=git_fixup_rebase_autosquash
alias glp="git log"
alias gapac=git_add_patch_and_commit
alias agapac="git add --intent-to-add . && git_add_patch_and_commit"
alias mr="gco master && ggpull"

# FIXME: add an alias for git rebase --onto origin/master 96a8ea41b6b05abb47f415db45e4510750869ae1 $(git_current_branch)
# maybe a general one not bound to master, and a thing to update the remote ref

# render an interactive git branch picker sorted by most recent commit
alias gbrecent='git branch --sort=-committerdate | fzf'

# override the zsh alias with one that does not include the `git add -A`
alias gwip='git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify -m "--wip-- [skip ci]"'

# interactively choose a commit hash from the last 30 in the log
alias glfhash="git log --oneline -n 30 | fzf --no-sort | awk '{print \$1}'"

alias diffu=diff_fancy_unified
alias diffj=diff_fancy_unified_json

alias format_json_file=jq_format_file
alias touchp=touch_p
alias ghpr=go_to_gh_pr
alias agr=global_find_replace
alias histog="sort -n | uniq -c | sort -nr"
alias dotfiles='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias restart='exec zsh -l'
