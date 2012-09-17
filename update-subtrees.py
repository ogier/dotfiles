#!/usr/bin/env python
"""
For each (remote, url, directory) in 'subtrees', add/fetch the changes from the
'url' to a named 'remote' in the current git repository. Then merge the changes
into 'directory' using the subtree strategy.

The command may stop to let you manually resolve conflicts.
"""

import subprocess

subtrees = [
    ('vundle', 'http://github.com/gmarik/vundle', 'home/vim/bundle/vundle'),
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

        cmd = 'git merge -s recursive -X subtree={0} {1}/master'.format(mount, remote)
        print cmd
        subprocess.check_call(cmd, shell=True)

if __name__ == '__main__':
    try:
        run()
    except subprocess.CalledProcessError as e:
        print(e)
