#!/bin/sh

# find the parent directory of this script
dotfiles=$(dirname "$(readlink -e "$0")")

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

    # only unlink if there's a symlink to $dotfiles
    if [ -h "$dest" -a "$(readlink "$dest")" = "$src" ]; then
        rm -v "$dest"
    fi
}

link_children ()
{
    src="$dotfiles/home/$1"
    dest="$HOME/.$1"

    mkdir -v -p "$dest"
    for child in "$src/"*; do
        link_dotfile "$1/$(basename "$child")"
    done
}



# shells

link_dotfile bash_profile
link_dotfile bashrc
link_dotfile zshrc

# vim

link_dotfile vimrc
link_dotfile vimrc.plugins
mkdir -v -p "$HOME/.vim/tmp/backup/"
mkdir -v -p "$HOME/.vim/tmp/swap/"

# tmux

link_dotfile tmux.conf

# git

link_dotfile gitconfig
link_dotfile gitignore

# hg

link_dotfile hgrc

# devilspie

link_children devilspie

# legacy removals

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
