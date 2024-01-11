#!/bin/sh

file_exists() {
    FILE=$1
    if ! test -f "$FILE"; then
        echo "$FILE doesn't exist."
        return 0
    fi
    echo "$FILE exists."
    return 1
}

append_to_file() {
    FILE=$1
    TEXT=$2
    echo $TEXT >> $FILE
    return 0
}

