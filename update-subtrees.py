#!/usr/bin/env python
"""
For each (remote, url, directory) in 'subtrees', add/fetch the changes from the
'url' to a named 'remote' in the current git repository. Then merge the changes
into 'directory' using the subtree strategy.

The command may stop to let you manually resolve conflicts.
"""

import subprocess

subtrees = [
    ('ack', 'http://github.com/mileszs/ack.vim', 'home/vim/bundle/ack.vim'),
    ('ctrlp', 'http://github.com/kien/ctrlp.vim', 'home/vim/bundle/ctrlp.vim'),
    ('gundo', 'http://github.com/sjl/gundo.vim', 'home/vim/bundle/gundo'),
    ('nerdcommenter', 'http://github.com/scrooloose/nerdcommenter', 'home/vim/bundle/NERD_commenter'),
    ('nerdtree', 'http://github.com/scrooloose/nerdtree', 'home/vim/bundle/nerdtree'),
    ('pathogen', 'http://github.com/tpope/vim-pathogen.git', 'pathogen'),
    ('scmdiff', 'http://github.com/ghewgill/vim-scmdiff', 'home/vim/bundle/vim-scmdiff/plugin'),
    ('searchcomplete', 'http://github.com/vim-scripts/SearchComplete', 'home/vim/bundle/SearchComplete'),
    ('snipmate', 'http://github.com/msanders/snipmate.vim', 'home/vim/bundle/snipmate.vim'),
    ('sudo', 'http://github.com/vim-scripts/sudo.vim', 'home/vim/bundle/sudo.vim'),
    ('supertab', 'http://github.com/ervandew/supertab', 'home/vim/bundle/supertab'),
    ('surround', 'http://github.com/tpope/vim-surround', 'home/vim/bundle/vim-surround'),
    ('taglist', 'http://github.com/vim-scripts/taglist.vim', 'home/vim/bundle/taglist'),
]

def run():
    git = subprocess.Popen(['git', 'remote'], stdout=subprocess.PIPE)
    remotes = git.communicate()[0].decode().splitlines()
    returncode = git.wait()
    if git.wait() != 0:
        raise subprocess.CalledProcessError(returncode, 'git remote')

    for remote, url, mount in subtrees:
        if remote not in remotes:
            subprocess.check_call('git remote add --no-tags -f {0} {1}'.format(remote, url), shell=True)
        else:
            subprocess.check_call('git fetch {0}'.format(remote), shell=True)

        subprocess.check_call('git merge -s recursive -X subtree={0} {1}/master'.format(mount, remote), shell=True)

if __name__ == '__main__':
    try:
        run()
    except subprocess.CalledProcessError as e:
        print(e)
