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

# OS X only
function install_keg()
{
  keg="$1"
  shift
  args="$*"
  if brew info $keg | grep 'Not installed' >/dev/null; then
    cmd="brew install $keg $args"
    echo $cmd
    brew install $keg $args;
  else
    echo "$keg already installed"
  fi
}

which brew && {
  for keg in msmtp gnupg contacts clojure scala sbt rbenv ruby-build urlview tree xz emacs notmuch watch; do 
    install_keg $keg
  done
  install_keg mutt --with-slang
}
