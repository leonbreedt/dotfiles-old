#!/bin/sh

syntax_check=`ruby -c $@ 2>&1`
if [ "$syntax_check" = "Syntax OK" ]; then
  output=`ruby -r test/unit $@ 2>&1`
  failed=$?
  if echo "$output" | grep "Run options:" &>/dev/null; then
    echo "$output"
    exit $failed
  else
    # possibly a problem with the test file (e.g. NameError)
cat <<EOF

  1) Error:
`echo "$output" | head -1 | cut -d: -f3-`
`echo "$output" | sed -e 's|^|    |g'`

EOF

  fi
else
cat <<EOF

  1) Error:
`echo $syntax_check | cut -d: -f3`
`echo "$syntax_check" | sed -e 's|^|    |g'`

EOF
  exit 1
fi
