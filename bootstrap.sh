#!/bin/sh

# bash

rm ~/.bash_profile
rm ~/.bashrc

ln -s ~/dotfiles/home/bash_profile ~/.bash_profile
ln -s ~/dotfiles/home/bashrc ~/.bashrc

# vim

rm ~/.vimrc

ln -s ~/dotfiles/home/vimrc ~/.vimrc

# git

rm ~/.gitconfig
rm ~/.gitignore

ln -s ~/dotfiles/home/gitconfig ~/.gitconfig
ln -s ~/dotfiles/home/gitignore ~/.gitignore
