#!/bin/sh

set -e

REMOTE=git://github.com/bitserf/dotfiles.git
LOCAL=$HOME/.dotfiles

if [ -e $LOCAL ]; then
  pushd $LOCAL
  git pull origin master
  popd
else
  git clone $REMOTE $LOCAL
fi
ruby $LOCAL/bin/link-dotfiles.rb
pushd $LOCAL
git submodule update --init
popd
