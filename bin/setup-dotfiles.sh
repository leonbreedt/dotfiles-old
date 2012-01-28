#!/bin/sh

set -e

REMOTE=git://github.com/bitserf/dotfiles.git
LOCAL=$HOME/.dotfiles

if [ -e $LOCAL ]; then
  git --git-dir=$LOCAL pull origin master
else
  git clone $REMOTE $LOCAL
fi
ruby $LOCAL/bin/link-dotfiles.rb
git --git-dir=$LOCAL submodule update --init
