#!/usr/bin/python
#
# Installs all the files and any template directories in 
# the same directory as this script to the home directory. 
# 

import getopt
import glob
import os
import shutil
from subprocess import Popen, PIPE
import sys

EXCLUDES = ['.git', 'README', 'install.py', '.placeholder']
DIFF = 'diff -u'
COLORDIFF = 'colordiff'

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
        p = Popen(DIFF.split() + [path1, path2], stdin=PIPE, stdout=PIPE)
        p.stdin.close()
        o = p.stdout.read()
        if p.wait() != 0:
            output = o
    else:
        p1 = Popen(DIFF.split() + [path1, path2], stdin=PIPE, stdout=PIPE)
        p2 = Popen(COLORDIFF.split(), stdin=p1.stdout, stdout=PIPE)
        o = p2.communicate()[0]
        if p1.wait() != 0:
            output  = o
    return output

def install_entry(srcpath, force=False, pretend=False, destdir="~"):
    entry_type = None
    if os.path.isfile(srcpath):
        entry_type = 'File'
    elif os.path.isdir(srcpath):
        entry_type = 'Directory'
    installed = False
    different = False
    tildepath = os.path.join(destdir, srcpath)
    destpath = os.path.expanduser(tildepath)

    def install(src, dest):
        skipped = False
        if os.path.isfile(src):
            if os.path.exists(dest) and not os.path.isfile(dest):
                skipped = True
            else:
                if not pretend:
                    shutil.copyfile(src, dest)
                print("Installed File %s" % tildepath)
        elif os.path.isdir(src):
            if os.path.exists(dest) and not os.path.isdir(dest):
                skipped = True
            else:
                if not pretend and not os.path.exists(dest):
                    os.makedirs(dest, mode=0775)
                print("Installed Directory %s" % tildepath)
        if skipped:
            print("Skipped %s %s, destination exists and is not a %s" % (entry_type, tildepath, entry_type))

    if os.path.exists(destpath):
        if force:
            install(srcpath, destpath)
            installed = True
        else:
            print("Skipped %s" % tildepath)
            if os.path.isfile(srcpath) and os.path.isfile(destpath):
                diff_output = diff(destpath, srcpath)
                if diff_output:
                    different = True
                    print(diff_output)
    else:
        install(srcpath, destpath)
        installed = True
    return (installed, different)

def strip_cwd(path):
    path = path.replace(os.getcwd(), '')
    if path[0] == '/': path = path[1:]
    return path

def recursive_entries(basepath, excludes=EXCLUDES):
    for item in [os.path.join(basepath, x)
                 for x in os.listdir(basepath)
                 if not os.path.basename(x) in excludes]:
        yield strip_cwd(item)
        if os.path.isdir(item):
            for child_item in recursive_entries(item):
                yield strip_cwd(child_item)

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

    dest_dir = os.environ["HOME"]
    if len(args) > 0:
        dest_dir = args[0]

    print("Installing to %s" % dest_dir)

    script_dir = os.path.abspath(os.path.dirname(sys.argv[0]))

    results = [install_entry(fn, force=force, pretend=pretend, destdir=dest_dir)
              for fn in recursive_entries(script_dir)]

    all_installed = all(x[0] for x in results) 
    any_different = any(x[1] for x in results)

    if not all_installed and any_different and not force:
        print("Note: Specify -f to overwrite existing files.")
    if any_different and not is_on_path("colordiff"):
        print("Note: Install 'colordiff' to get nice diff output.")
