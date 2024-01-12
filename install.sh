#!/bin/bash

# shellcheck source=src/common/filesystem.sh
source src/common/filesystem.sh

create_alias() {
    # ALIAS_FILE="~/.alias"
    ALIAS_FILE="alias.txt"
    echo "Creating $ALIAS_FILE"
    create_file "$ALIAS_FILE"
    grep -v '^ *#' < "data/aliases" | while IFS= read -r alias
    do
        append_to_file $ALIAS_FILE "$alias\n"
    done
}

# FILE="example.txt"
# if (file_exists $FILE -eq 0); then
#     create_file $FILE
# fi

# ALIAS_LOAD="if [ -f ~/.alias ]; then\n    echo \"Loading your alias\"\n    . ~/.alias\nfi"

# append_to_file $FILE "$ALIAS_LOAD"

echo "Hello it is installed"

create_alias

exit 0
