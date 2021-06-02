#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="tmux.conf bashrc bash_profile vimrc vim nvimrc"    # list of files/folders to symlink in homedir
fish_dir=~/.config/fish                    # fish dir
fish_files="config.fish fish_variables"

##########

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

for file in $fish_files; do
  echo "Moving fish config from $fish_dir to $olddir"
  mv $fish_dir/$file ~/dotfiles_old
  echo "Creating symlink to $file in fish config directory."
  ln -s $dir/$file $fish_dir/$file
done
