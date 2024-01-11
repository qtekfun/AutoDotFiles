#!/bin/bash

# shellcheck source=src/common/filesystem.sh
source src/common/filesystem.sh

FILE="example.txt"
if (file_exists $FILE -eq 0); then
    touch $FILE
fi

ALIAS_LOAD="if [ -f ~/.alias ]; then\n    echo \"Loading your alias\"\n    . ~/.alias\nfi"

append_to_file $FILE "$ALIAS_LOAD"

echo "Hello it is installed"

exit 0
