#!/bin/sh

# Find the parent directory of this script
dotfiles="$(dirname "$(readlink -e "$0")")"

link_dotfile ()
{
    src="$dotfiles/home/$1"
    dest="$HOME/.$1"

    # if there's already a proper link set up, do nothing
    if [ -h "$dest" -a "$(readlink "$dest")" = "$src" ]; then
        return
    fi

    # ask before clobbering anything
    if [ -f "$dest" -o -d "$dest" ]; then
        read -p "Clobber $1 ? " yn
        case "$yn" in
            [Yy]* ) rm -r "$dest"; break;;
            * ) echo "Skipping $dest"; return;;
        esac
    fi

    ln -v -s "$src" "$dest"
}

unlink_dotfile ()
{
    src="$dotfiles/home/$1"
    dest="$HOME/.$1"

    # only unlink if there's a symlink and it points to us
    if [ -h "$dest" -a "$(readlink "$dest")" = "$src" ]; then
        rm -v "$dest"
    fi
}

# bash

link_dotfile bashrc
link_dotfile bash_profile

# zsh

link_dotfile zshrc

# git

link_dotfile gitconfig
link_dotfile gitignore

# hg

link_dotfile hgrc

# tmux

link_dotfile tmux.conf

# vim

link_dotfile vimrc
link_dotfile vimrc.plugins
# Do some first time initialization for vim
mkdir -v -p "$HOME/.vim/tmp/backup/"
mkdir -v -p "$HOME/.vim/tmp/swap/"
# Clone vundle if there's not already a repo there
if [ ! -d "$HOME/.vim/bundle/vundle" ]; then
    git clone https://github.com/gmarik/vundle "$HOME/.vim/bundle/vundle"
fi

# Unlink some legacy files (files that used to be managed)
unlink_dotfile devilspie/terminal.ds
unlink_dotfile vim/autoload/pathogen.vim
unlink_dotfile vim/colors/molokai.vim
unlink_dotfile vim/bundle/ack.vim
unlink_dotfile vim/bundle/ctrlp.vim
unlink_dotfile vim/bundle/gundo.vim
unlink_dotfile vim/bundle/NERD_commenter
unlink_dotfile vim/bundle/nerdcommenter
unlink_dotfile vim/bundle/nerdtree
unlink_dotfile vim/bundle/SearchComplete
unlink_dotfile vim/bundle/snipmate.vim
unlink_dotfile vim/bundle/sudo.vim
unlink_dotfile vim/bundle/supertab
unlink_dotfile vim/bundle/taglist.vim
unlink_dotfile vim/bundle/vim-scmdiff
unlink_dotfile vim/bundle/vim-surround
unlink_dotfile vim/bundle/vim-yankring
