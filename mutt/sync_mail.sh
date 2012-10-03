#!/bin/bash
tmp=~/.mutt/tmp/offlineimap.$$.log
trap "rm -f $tmp" EXIT
if [ "$1" != "" ]; then
  echo "Syncing mail in $1..."
  offlineimap -u machineui -qf "$1" >$tmp
  n=$(grep "$1" $tmp | grep 'Copy message from' | wc -l | awk '{ print $1 }')
else
  echo "Syncing all mail..."
  offlineimap -u machineui >$tmp
  n=$(grep INBOX $tmp | grep 'Copy message from' | wc -l | awk '{ print $1 }')
fi
[ $n -gt 0 ] && terminal-notifier -message 'You have new mail' -title 'Mail' -subtitle "$n new messages" >/dev/null
