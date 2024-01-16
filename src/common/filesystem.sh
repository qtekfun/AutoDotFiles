#!/bin/bash

file_exists() {
    FILE=$1
    if ! test -f "$FILE"; then
        return 0
    fi
    return 1
}

append_to_file() {
    FILE=$1
    TEXT=$2
    printf "$TEXT\n" >> $FILE
    return 0
}

find_in_file() {
    FILE="$1"
    TEXT="$2"
    OUTPUT=$(grep -c "$2" "$1")
    if [ "$OUTPUT" -gt "0" ]; then
        return 1
    fi
    return 0
}

create_file() {
    FILE=$1
    touch "$1"
    return 0
}
