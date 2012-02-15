#!/bin/sh

. $(dirname $0)/functions

formatted_test "ruby -r test/unit" "^Finished" "$1"
