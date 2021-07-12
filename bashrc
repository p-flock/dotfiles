
# keymaps
alias ls='ls -G'
alias la='ls -a'
# get to workspace faster
# run python faster
alias python='usr/local/bin/python3'
# run python interactive faster
alias pi='python3 -i'
# gtfo faster
alias cd.='cd ..'
alias bu='ssh pflock@csa2.bu.edu'
alias bu3='ssh pflock@csa3.bu.edu'
alias bu1='ssh pflock@csa1.bu.edu'

# crontab needs editor specified
alias cront='env EDITOR=nvim crontab -e'

#set $GOPATH
export GOPATH=$HOME/work
# kqueue is broken on mac OS, tmux complains
export EVENT_NOKQUEUE=1

# YOLO = sudo
alias yolo='sudo'
# YOLO='sudo `!!`'
alias YOLO='sudo $(fc -ln -1)'
# custom binding from Ctr-k to gif
bind '"\C-k"':"\"gifme\C-m\""


# for git branch

RED="\[\033[0;31m\]"
GREEN="\[\033[0;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
YELLOW="\[\033[0;33m\]"
BLUE="\[\033[0;34m\]"
LIGHT_PURPLE="\[\033[1;35m\]"
LIGHT_CYAN="\[\033[1;36m\]"
WHITE="\[\033[00m\]"
#export PS1="$LIGHT_GREEN\u 🍰 $LIGHT_CYAN \w$WHITE:\$"
export PS1='\n\[\033[1;36m\]$(pwd)\n\[\033[1;32m\]\u🍰\[\033[00m\]:\$ '

# display random gif plz
#gifme

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
