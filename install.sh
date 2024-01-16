#!/bin/bash

# shellcheck source=src/common/filesystem.sh
source src/common/filesystem.sh
# shellcheck source=src/common/logging.sh
source src/common/logging.sh

create_alias() {
    ALIAS_FILE="$HOME/.alias"
    BASH_ALIASES="$HOME/.bash_aliases"

    file_exists "$BASH_ALIASES"
    if [ $? -eq 1 ]; then
        log "Alias file will be replaced to $BASH_ALIASES"
        ALIAS_FILE="$BASH_ALIASES"
        log "Alias file is $ALIAS_FILE"
    else
        log "Creating $ALIAS_FILE"
        create_file "$ALIAS_FILE"
        if [ $? -eq 0 ]; then
            log "Created $ALIAS_FILE"
        fi
    fi

    grep -v '^ *#' < "data/aliases" | while IFS= read -r alias
    do
        find_in_file "$ALIAS_FILE" "$alias"
        if [ $? -eq 0 ]; then
            append_to_file "$ALIAS_FILE" "$alias"
            log "Alias \"$alias\" created"
        else
            log "Alias \"$alias\" already exists"
        fi
    done

    BASHRC="$HOME/.bashrc"
    file_exists "$BASHRC"
    if [ $? -eq 0 ]; then
        ERROR_MSG="$BASHRC file not exists. FATAL ERROR"
        log "$ERROR_MSG"
        echo "$ERROR_MSG"
        return 2
    else
        # Do the installation
        log "Installing Aliases in $BASHRC"
        ALIAS_LOAD="if [ -f $ALIAS_FILE ]; then\n    echo \"Loading your alias\"\n    . $ALIAS_FILE\nfi"
        find_in_file "$BASHRC" "if \[ -f $ALIAS_FILE \]; then"
        if [ $? -eq 0 ] && [ "$ALIAS_FILE" != "$BASH_ALIASES" ]; then
            append_to_file "$BASHRC" "$ALIAS_LOAD"
            log "Alias correctly installed"
        else
            log "Alias already installed"
        fi
    fi
}

echo "AutoDotFiles started"

create_alias

echo "AutoDotFiles finished"

exit 0
