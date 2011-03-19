#!/bin/sh

dotfiles=~/dotfiles/home

link_absolute ()
{
    # if theres something there already
    if [ -f $1 -o -d $1 ]; then
        # if it's not a symlink already, confirm
        if [ ! -h $1 ]; then
            read -p "Clobber $1 ? " yn
            case $yn in
                [Yy]* ) break;;
                * ) echo "Skipping $1"; return;;
            esac
        fi
        rm -r $1
    fi
    ln -v -s $2 $1
}

link_dotfile ()
{
    link_absolute ~/.$1 $dotfiles/$1
}

link_children ()
{
    mkdir -v -p $1
    for child in $2/*; do
        link_absolute $1/`basename $child` $child
    done
}


# bash

link_dotfile bash_profile
link_dotfile bashrc

# vim

link_dotfile vimrc
mkdir -v -p ~/.vim/tmp/backup//
mkdir -v -p ~/.vim/tmp/swap//
for dir in ~/dotfiles/home/vim/*; do
    link_children ~/.vim/`basename $dir` $dir
done

# git

link_dotfile gitconfig
link_dotfile gitignore

# hg

link_dotfile hgrc
