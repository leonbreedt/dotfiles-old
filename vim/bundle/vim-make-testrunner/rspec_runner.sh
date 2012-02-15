#!/bin/sh

DIR=$(dirname $0)
. $DIR/functions

if [ "$VERBOSE" = "1" ]; then
  command="rspec -f documentation --color"
else
  command="rspec -f RSpec::Core::Formatters::VimFormatter -r $DIR/vim_formatter.rb"
fi

formatted_test "$command" '^$' "$1"
