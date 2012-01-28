#!/bin/sh

set -e

REMOTE=git://github.com/bitserf/dotfiles.git
LOCAL=$HOME/.dotfiles

if [ -e $LOCAL ]; then
  cd $LOCAL
  git pull origin master
else
  git clone $REMOTE $LOCAL
  cd $LOCAL
fi
ruby bin/link-dotfiles.rb
git submodule update --init
