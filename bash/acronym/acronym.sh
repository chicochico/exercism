#!/usr/bin/env bash

# Using parameter expansions

# ${variable//search/replace}
# search: will match three characters - or _ or *
# first clean up dashes and glob character
# then word split
phrase="${*//[^[a-zA-Z\']/ }"
for word in $phrase; do
    result+="${word:0:1}"
done

# ${parameter@operator} - U converts parameter to uppercase
echo "${result@U}"
