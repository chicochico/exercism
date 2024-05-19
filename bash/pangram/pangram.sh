#!/usr/bin/env bash

# 1. remove everything that is not [a..z]
# 2. sort
# 3. deduplicate
# 4. count length should be = 26
#
# use ${parameter@operator} to lowercase
# L - tranform to lowercase
lowercased=${1@L}
result=$(grep -o "[a-z]" <<<"$lowercased" | sort | uniq)

# output result
[ "$(wc -l <<<"$result")" == 26 ] && echo "true" || echo "false"
