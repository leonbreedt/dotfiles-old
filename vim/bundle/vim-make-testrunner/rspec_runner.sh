#!/bin/sh

DIR=$(dirname $0)
. $DIR/functions

formatted_test "rspec -f RSpec::Core::Formatters::VimFormatter -r
$DIR/vim_formatter.rb" $@
