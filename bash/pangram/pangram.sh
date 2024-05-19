#!/usr/bin/env bash

# pure bash based on one of community solutions
# 1. use alphabet as starting point
# 2. for every character in the input delete it from alphabet
# 3. if result is length zero (empty stsring) it is a pangram
lowercased=${1@L}
alphabet="abcdefghijklmnopqrstuvwxyz"
is_empty=${alphabet//[$lowercased]/}

[ -z "$is_empty" ] && echo "true" || echo "false"
