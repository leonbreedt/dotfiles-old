#!/bin/sh

set -e

REMOTE=git://github.com/bitserf/dotfiles.git
LOCAL=$HOME/.dotfiles

if [ -e "$HOME/.dotfiles" ]; then
  git clone $REMOTE $LOCAL
else
  git --git-dir=$LOCAL pull origin master
fi
ruby $LOCAL/bin/link-dotfiles.rb
git --git-dir=$LOCAL submodule update --init
