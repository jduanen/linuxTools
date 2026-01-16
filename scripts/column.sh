#!/bin/bash
# Script to turn csv file into table

FILE_PATH=${1}
OPTS=""  # --table-truncate 1

if [ $# -ne 3 ]; then
    echo "Usage: $0 {<options>} <filePath>"
    exit 1
fi

column -s, -t ${OPTS} < ${FILE_PATH}
