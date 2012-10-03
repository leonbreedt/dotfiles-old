#!/usr/bin/python
import re, subprocess
def get_keychain_pass(account=None, server=None):
    params = {
        'security': '/usr/bin/security',
        'command': 'find-internet-password',
        'account': account,
        'server': server,
        'keychain': '/Users/ljb/Library/Keychains/login.keychain',
    }
    command = "sudo -u ljb %(security)s -v %(command)s -g -a %(account)s -s %(server)s %(keychain)s" % params
    output = subprocess.check_output(command, shell=True, stderr=subprocess.STDOUT)
    outtext = [l for l in output.splitlines()
               if l.startswith('password: ')][0]

    return re.match(r'password: "(.*)"', outtext).group(1)

if __name__ == '__main__':
  import sys
  if len(sys.argv) >= 3:
    print(get_keychain_pass(sys.argv[1], sys.argv[2]))
  else:
    sys.stderr.write("usage: offlineimap.py username account\n")
    sys.exit(1)
