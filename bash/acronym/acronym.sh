#!/usr/bin/env bash

# Using parameter expansions

# ${variable//search/replace}
#
# search: will match non-letter and non-dashes
# and replace with space, this also removes glob
# character *
#
# then word split
phrase="${*//[^[a-zA-Z\']/ }"
for word in $phrase; do
    result+="${word:0:1}"
done

# ${parameter@operator} - U converts parameter to uppercase
echo "${result@U}"
