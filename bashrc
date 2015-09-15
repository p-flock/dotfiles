# keymaps
alias ls='ls -G'
alias la='ls -a'
# get to workspace faster
alias cs112='cd "/Users/peterflockhart/Dropbox/Higher Education/Spring 2015/CS112"'
alias cs235='cd "/Users/peterflockhart/Dropbox/Higher Education/Spring 2015/CS 235"'
# run python faster
alias py='python3'
# run python interactive faster
alias pi='python3 -i'
# gtfo faster
alias cd.='cd ..'
alias bu='pflock@csa2.bu.edu'

# use updated vim
alias vim='/Applications/MacVim.app/Contents/MacOS/vim'

function parse_git_branch {
    echo git branch> /dev/null |sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

RED="\[\033[0;31m\]"
GREEN="\[\033[0;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
YELLOW="\[\033[0;33m\]"
BLUE="\[\033[0;34m\]"
LIGHT_PURPLE="\[\033[1;35m\]"
LIGHT_CYAN="\[\033[1;36m\]"
WHITE="\[\033[00m\]"
export PS1="$LIGHT_GREEN\h$LIGHT_CYAN \w$WHITE:$YELLOW\$(parse_git_branch)$WHITE\$"


