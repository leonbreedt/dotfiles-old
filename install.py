import getopt
import glob
import os
import shutil
import sys

def install_dotfile(srcpath, force=False):
    installed = False
    tildepath = "~/%s" % srcpath
    destpath = os.path.expanduser(tildepath)
    if force or not os.path.exists(destpath):
        print("Installing %s" % tildepath)
        shutil.copyfile(srcpath, destpath)
        installed = True
    else:
        print("%s already exists." % tildepath)
    return installed

if __name__ == "__main__":
    force = False
    opts, args = getopt.getopt(sys.argv[1:], 'f')
    for o, v in opts:
        if o == "-f":
            force = True
    files_installed = [install_dotfile(fn, force=force) 
                       for fn in glob.glob('.*')
                       if fn != '.git']
    if not all(files_installed):
        print("\nSpecify -f to overwrite existing files.")
