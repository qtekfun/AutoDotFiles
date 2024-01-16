#!/bin/bash

# shellcheck source=src/common/filesystem.sh
source src/common/filesystem.sh

log() {
    LOG_FILE="./log.txt"
    if [ "$2" ]; then
        LOG_FILE=$2
    fi
    echo $LOG_FILE
    file_exists $LOG_FILE
    if [ $? -eq 0 ]; then
        create_file $LOG_FILE
    fi
    LOG_TEXT="$(date +%y/%m/%d_%H:%M:%S)::$1"
    append_to_file $LOG_FILE "$LOG_TEXT"
    return 0
}