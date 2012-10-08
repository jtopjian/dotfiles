#!/bin/bash

########## Variables

dir=~/.dotfiles                    # dotfiles directory
olddir=~/.dotfiles_old             # old dotfiles backup directory
files=`cd $dir; ls -d .[a-z]* | grep -v .git$`    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
if [ ! -d $olddir ]; then
    echo "Creating $olddir for backup of any existing dotfiles in ~"
    mkdir -p $olddir
    echo "...done"
fi

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
    if [ -a ~/$file -a ! -h ~/$file ]; then
        echo "Moving existing $file from ~ to $olddir"
        mv ~/$file $olddir/
    fi
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/$file
done
