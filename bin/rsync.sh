#!/bin/bash
# Script to copy local dirs/files to remote location
# (with ssh and compression)

USR="jdn"
REM_HOST=${1}
SRC_PATH=${2}
DST_PATH=${3}

OPTS=""  # --dry-run

if [ $# -ne 3 ]; then
    echo "Usage: $0 <remoteHost> <srcPath> <dstPath>"
    exit 1
fi

rsync -avz ${OPTS} ${SRC_PATH}/ ${USR}@${REM_HOST}.lan:${DST_PATH}
