Installation
============

    git clone http://github.com/ogier/dotfiles
    ./dotfiles/bootstrap.sh

Explanation
===========

The bootstrap script that is included will synchronize your home directory with
the `home/` directory from dotfiles by symlinking any relevant files.
The bootstrapper is very cautious. It will ask for confirmation before
changing any unrecognized file or symlink so it is safe to run even if
you have local changes you want to keep.

Because `~/.gitconfig` includes personal information and is unable to use
paths that are relative to the home directory, you will probably have to
manually edit that file before it is useful.

Vim plugins are managed via Vundle in the file `~/.vimrc.plugins`. The first
time you run vim, you may find that the colorscheme is missing and some errors
may be displayed. Running `:BundleInstall` from within vim should fix these
for the next time you open vim.
