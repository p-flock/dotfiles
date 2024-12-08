set -g __fish_git_prompt_show_informative_status 0
set -g __fish_git_prompt_hide_untrackedfiles 1

set -g __fish_git_prompt_color_branch magenta
set -g __fish_git_prompt_showupstream informative
set -g __fish_git_prompt_char_upstream_ahead "↑"
set -g __fish_git_prompt_char_upstream_behind "↓"
set -g __fish_git_prompt_char_upstream_prefix ""

set -g __fish_git_prompt_char_stagedstate "●"
set -g __fish_git_prompt_char_dirtystate "✚"
set -g __fish_git_prompt_char_untrackedfiles "…"
set -g __fish_git_prompt_char_conflictedstate "✖"
set -g __fish_git_prompt_char_cleanstate "✔"

set -g __fish_git_prompt_color_dirtystate blue
set -g __fish_git_prompt_color_stagedstate yellow
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
set -g __fish_git_prompt_color_cleanstate green

alias cat="bat"

function nv
    nvim
end

function fix
    git commit --fixup HEAD
end

function fp
    git push -f
end

function gp
    git pull
end

function am
  git commit --amend --no-edit
end

function cover
    open coverage/index.html
end

function s
    git status
end

function gl
    git log
end

function glo
    git log --oneline
end

function vimlog
    git log | nvim -R -
end

function stash
    git stash
end

function apply
    git stash apply
end

function lsd
    ls -d */
end

function dockerize
    docker run --rm -it -v $PWD:$PWD -w $PWD ubuntu bash
end

function vlc
    nvim -O (git log --pretty=format: --name-only -n 1)
end

function gsup
    set BRANCH (git rev-parse --abbrev-ref HEAD 2>/dev/null)
    git push --set-upstream origin $BRANCH
end

function gpr
    gsup
    git pull-request -o -c
end

function mydiff
  GIT_EXTERNAL_DIFF=difft git log -p --ext-diff
end

function rebase
    set stash_ref (git stash create)
    git restore .
    git checkout main
    git pull
    git checkout -
    git rebase main
    if [ "$stash_ref" != "" ]
      git stash apply "$stash_ref"
    end
end


function fish_prompt
    set_color FF0
    echo '│' (pwd) '>'
    echo -n '│ '
    set_color normal
end

function fish_greeting
    set_color purple
    echo
    echo "W̶̥̫̥͆ḛ̸̥̿ͅḽ̵̻͓̋̀͝c̶͙͈̗͛̐̀̏o̵̿̈́̄̉̚͜m̴̼̟̘̼̓ẹ̶̡͔͂̉̊̃͜͝ ̷̛̯̯̏Ḫ̵̣̫͒̽ó̵̯̽̕m̴̯̚e̷̺̝̦͒͋́͑:" (date)
    echo
end


# tte slide is very slow unfortunately, so this is annoying
# when frequently opening terminals
#function fish_greeting
    #set_color purple
    #echo
    #echo "W̶̥̫̥͆ḛ̸̥̿ͅḽ̵̻͓̋̀͝c̶͙͈̗͛̐̀̏o̵̿̈́̄̉̚͜m̴̼̟̘̼̓ẹ̶̡͔͂̉̊̃͜͝ ̷̛̯̯̏Ḫ̵̣̫͒̽ó̵̯̽̕m̴̯̚e̷̺̝̦͒͋́͑:" (date)
    #echo
    #echo "
            #__..--''``---....___   _..._    __
 #/// //_.-'    .-/\";  `        ``<._  ``.''_ `. / // /
#///_.-' _..--.'_    \                    `( ) ) // //
#/ (_..-' // (< _     ;_..__               ; `' / ///
 #/ // // //  `-._,_)' // / ``--...____..-' /// / //

    #" | tte slide
#end

set PATH /usr/local/opt/gnu-sed/libexec/gnubin:$PATH
set PATH $HOME/.cargo/bin $PATH
fish_add_path ./node_modules/.bin

# Setting PATH for Python 3.9
# The original version is saved in /Users/pflockhart/.config/fish/config.fish.pysave
set -x PATH "/Library/Frameworks/Python.framework/Versions/3.9/bin" "$PATH"

# Created by `pipx` on 2024-05-29 19:21:24
set PATH $PATH /Users/peterflockhart/.local/bin
