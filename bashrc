# use vim 7.4
alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'

# keymaps
alias ls='ls -G'
alias la='ls -a'
# get to workspace faster
alias linear='cd "/Users/peterflockhart/Dropbox/Higher Education/Fall 2015/LInear Algebra"'
alias cs235='cd "/Users/peterflockhart/Dropbox/Higher Education/Spring 2015/CS 235"'
# run python faster
alias py='python3'
# run python interactive faster
alias pi='python3 -i'
# gtfo faster
alias cd.='cd ..'
alias bu='ssh pflock@csa2.bu.edu'
alias bu3='ssh pflock@csa3.bu.edu'
alias bu1='ssh pflock@csa1.bu.edu'

# crontab needs editor specified
alias cront='env EDITOR=vim crontab -e'

#set $GOPATH
export GOPATH=$HOME/work

# YOLO = sudo
alias yolo='sudo'
# YOLO='sudo `!!`'
alias YOLO='sudo $(fc -ln -1)'
# custom binding from Ctr-k to gif
bind '"\C-k"':"\"gifme\C-m\""



function parse_git_branch {
    echo git branch> /dev/null |sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
# git branch

RED="\[\033[0;31m\]"
GREEN="\[\033[0;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
YELLOW="\[\033[0;33m\]"
BLUE="\[\033[0;34m\]"
LIGHT_PURPLE="\[\033[1;35m\]"
LIGHT_CYAN="\[\033[1;36m\]"
WHITE="\[\033[00m\]"
export PS1="$LIGHT_GREEN\u 🍰 $LIGHT_CYAN \w$WHITE:$YELLOW\$(parse_git_branch)$WHITE\$"


# display random gif plz
gifme
