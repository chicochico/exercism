#!/usr/bin/env bash

main() {
    local name
    name="$1"
    if [ -z "$name" ]; then
        echo "One for you, one for me."
    else
        echo "One for ${name}, one for me."
    fi
}

main "$@"
