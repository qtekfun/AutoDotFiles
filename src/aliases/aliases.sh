#!/bin/sh

echo "Root execution path is $1"

# shellcheck source=$SCRIPTPATH/filesystem.sh
. $1/src/common/filesystem.sh

file_exists $HOME/.aliases

# SCRIPT=$(realpath "$0")
# SCRIPTPATH=$(dirname "$SCRIPT")
# echo $SCRIPTPATH

# grep -v '^ *#' < $SCRIPTPATH/aliases_data | while IFS= read -r line
# do
#   echo "Alias: $line"
#   echo $line >> $FILE
# done

# cat $FILE