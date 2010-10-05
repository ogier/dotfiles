#!/usr/bin/env sh

# bash

rm ~/.bash_profile
rm ~/.bashrc

ln -s ~/dotfiles/home/bash_profile ~/.bash_profile
ln -s ~/dotfiles/home/bashrc ~/.bashrc

# vim

rm ~/.vimrc

ln -s ~/dotfiles/home/vimrc ~/.vimrc
