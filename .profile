# NVM (assumes homebrew installation)

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# PYTHON

# Setting PATH for Python 3.6 (this doesn't appear to be required to get the aws cli working properly)
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH

# ALIASES

# Git
alias glom='git pull origin master' # new
alias gcam='git add .; git commit -m' # overridden, to include untracked files

# This adds the "dotfiles" alias, used for sharing my dotfiles (see README_DOTFILES.md)
alias dotfiles='/usr/bin/git --git-dir=/Users/liam/.cfg/ --work-tree=/Users/liam'
