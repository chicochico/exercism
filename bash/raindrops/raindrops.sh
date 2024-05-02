#!/usr/bin/env bash

dividend=$1
result=""

if [[ $((dividend % 3)) -eq 0 ]]; then
    result+="Pling"
fi

if [[ $((dividend % 5)) -eq 0 ]]; then
    result+="Plang"
fi

if [[ $((dividend % 7)) -eq 0 ]]; then
    result+="Plong"
fi

if [[ -z $result ]]; then
    result="${dividend}"
fi

echo "$result"
