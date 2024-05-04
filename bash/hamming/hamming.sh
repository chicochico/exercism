#!/usr/bin/env bash

a=$1
b=$2
length_a=${#a}
length_b=${#b}

# Validations
#
# No argumments passed
if [[ $# -lt 2 ]]; then
    echo "Usage: hamming.sh <string1> <string2>"
    exit 1
fi

# Different lenghts inputs
if ((length_a != length_b)); then
    echo "strands must be of equal length"
    exit 1
fi

diffs=0

# Iterate over chars in string
#
for ((i = 0; i < length_a; i++)); do
    if [[ "${a:$i:1}" != "${b:$i:1}" ]]; then
        ((diffs += 1))
    fi
done

echo "$diffs"
