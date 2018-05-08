# PATH
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

export PATH=~/Library/Python/3.6/bin:$PATH

# ALIASES
alias glom='git pull origin master' # new
alias gcam='git add .; git commit -m' # overridden, to include untracked files

# This adds the "config" alias, used for sharing my dotfiles
alias config='/usr/bin/git --git-dir=/Users/liam/.cfg/ --work-tree=/Users/liam'
