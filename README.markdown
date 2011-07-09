Setting up
==========

Check out by running 
`git clone http://github.com/ogier/dotfiles ~/dotfiles --recursive`
or running `git submodule update --init` after cloning.

Then run `~/dotfiles/bootstrap.sh`. This will add a bunch of symlinks
from your home directory to `~/dotfiles/home`. The bootstrapper is very
paranoid, it will ask for confirmation before deleting any existing files
so it is safe to run even if you have local changes you want to keep.

It is assumed that this repository was checked out to
`~/dotfiles`. I may add more customizability if it turns out to be helpful.

Recap
-----

    git clone http://github.com/ogier/dotfiles ~/dotfiles --recursive
    ~/dotfiles/bootstrap.sh

That's it.
