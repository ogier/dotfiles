#!/bin/sh

# optionally specify an alternate repository location as the first argument
if [ -z "$1" ]; then
    dotfiles="$HOME/dotfiles"
else
    dotfiles="$1"
fi

link_absolute ()
{
    # if there's already a proper link set up, do nothing
    if [ -h "$1" -a "`readlink \"$1\"`" = "$2" ]; then
        return
    fi

    # ask before clobbering anything
    if [ -f "$1" -o -d "$1" ]; then
        read -p "Clobber $1 ? " yn
        case "$yn" in
            [Yy]* ) rm -r "$1"; break;;
            * ) echo "Skipping $1"; return;;
        esac
    fi

    ln -v -s "$2" "$1"
}

unlink_absolute ()
{
    # only unlink if there's a symlink to $dotfiles
    if [ -h "$1" -a "`readlink \"$1\"`" = "$2" ]; then
        rm -v "$1"
    fi
}

link_dotfile ()
{
    link_absolute "$HOME/.$1" "$dotfiles/home/$1"
}

unlink_dotfile ()
{
    unlink_absolute "$HOME/.$1" "$dotfiles/home/$1"
}

link_children ()
{
    mkdir -v -p "$1"
    for child in "$2/"*; do
        link_absolute "$1/`basename $child`" "$child"
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

link_children "$HOME/.devilspie" "$dotfiles/home/devilspie"

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
