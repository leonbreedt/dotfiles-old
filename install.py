#!/usr/bin/python

import getopt
import glob
import os
import shutil
from subprocess import Popen, PIPE
import sys

# thanks, stackoverflow!
def is_on_path(program):
    def can_execute(fpath):
        return os.path.exists(fpath) and os.access(fpath, os.X_OK)

    fpath, fname = os.path.split(program)
    if fpath:
        if can_execute(program):
            return program
    else:
        for path in os.environ["PATH"].split(os.pathsep):
            exe_file = os.path.join(path, program)
            if can_execute(exe_file):
                return exe_file

def diff(path1, path2):
    diff_path = is_on_path("diff")
    colordiff_path = is_on_path("colordiff")
    if not diff_path:
        print("Error: No diff command in PATH")
        sys.exit(1)
    output = None
    if not colordiff_path:
        p = Popen(["diff", "-u", path1, path2], stdin=PIPE, stdout=PIPE)
        p.stdin.close()
        o = p.stdout.read()
        if p.wait() != 0:
            output = o
    else:
        p1 = Popen(["diff", "-u", path1, path2], stdin=PIPE, stdout=PIPE)
        p2 = Popen(["colordiff"], stdin=p1.stdout, stdout=PIPE)
        o = p2.communicate()[0]
        if p1.wait() != 0:
            output  = o
    return output

def install_dotfile(srcpath, force=False, pretend=False):
    def install(src, dest):
        if not pretend:
            shutil.copyfile(src, dest)
        print("Installed %s" % tildepath)

    installed = False
    different = False
    tildepath = "~/%s" % srcpath
    destpath = os.path.expanduser(tildepath)
    if os.path.exists(destpath):
        if force:
            install(srcpath, destpath)
            installed = True
        else:
            print("Skipped %s" % tildepath)
            diff_output = diff(destpath, srcpath)
            if diff_output:
                different = True
                print(diff_output)
    else:
        install(srcpath, destpath)
        installed = True
    return (installed, different)

if __name__ == "__main__":
    force = False
    pretend = False
    try:
        opts, args = getopt.getopt(sys.argv[1:], 'fp')
    except getopt.GetoptError as detail:
        print("Error: %s" % detail)
        sys.exit(1)
    for o, v in opts:
        if o == "-f": force = True
        elif o == "-p": pretend = True

    results = [install_dotfile(fn, force=force, pretend=pretend)
               for fn in glob.glob('.*')
               if fn != '.git']

    all_installed = all(x[0] for x in results) 
    any_different = any(x[1] for x in results)

    if not all_installed and any_different and not force:
        print("Note: Specify -f to overwrite existing files.")
    if any_different and not is_on_path("colordiff"):
        print("Note: Install 'colordiff' to get nice diff output.")
