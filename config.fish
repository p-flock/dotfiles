# Fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'none'
set __fish_git_prompt_color_branch purple
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red

# Status Chars
set __fish_git_prompt_char_dirtystate 'ȯ'
set __fish_git_prompt_char_stagedstate ''
set __fish_git_prompt_char_untrackedfiles ''
set __fish_git_prompt_char_stashstate ''
set __fish_git_prompt_char_upstream_ahead ''
set __fish_git_prompt_char_upstream_behind ''

function nv
  nvim
end

function lsd
  ls -d */
end

alias cat='bat'
alias git='hub'
alias python='/usr/local/bin/python3'
function vlc
  nvim -O (git log --pretty=format: --name-only -n 1)
end
function gsup
  set BRANCH (git rev-parse --abbrev-ref HEAD 2>/dev/null);
  git push --set-upstream origin $BRANCH
end
function gpr
  gsup
  git pull-request -o -c
end


function fish_prompt
      set_color FF0
      echo '│'  (pwd) '>'
      echo -n '└─ '
      set_color normal
end

function fish_greeting
      set_color purple
      echo
      echo "W̶̥̫̥͆ḛ̸̥̿ͅḽ̵̻͓̋̀͝c̶͙͈̗͛̐̀̏o̵̿̈́̄̉̚͜m̴̼̟̘̼̓ẹ̶̡͔͂̉̊̃͜͝ ̷̛̯̯̏Ḫ̵̣̫͒̽ó̵̯̽̕m̴̯̚e̷̺̝̦͒͋́͑:" (date)
      echo
end

set PATH $HOME/.cargo/bin $PATH
