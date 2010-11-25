#!/bin/sh

link_file ()
{
    if [ -f ~/$1 ]; then
        read -p "Clobber ~/$1 ? " yn
        case $yn in
            [Yy]* ) rm ~/$1; break;;
            * ) echo "Skipping $1"; return;;
        esac
    fi
    echo "~/$1 -> ~/dotfiles/home/$2"
    ln -s ~/dotfiles/home/$2 ~/$1
}

# bash

link_file .bash_profile bash_profile
link_file .bashrc bashrc

# vim

link_file .vimrc vimrc

# git

link_file .gitconfig gitconfig
link_file .gitignore gitignore
