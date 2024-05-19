#!/usr/bin/env bash

# length as a string
digits_count=${#1}

result=0
n=$1
while (("$n" > 0)); do
    digit=$((n % 10))
    result=$((result + digit ** digits_count))
    n=$((n / 10))
done

((result == $1)) && echo "true" || echo "false"
