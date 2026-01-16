#!/bin/bash
# Script to find the most recent file of a given type in a given directory

if [ $# -ne 4 ]; then
    echo "Usage: $0 <fileExt> <dirPath> <numFiles> <maxDepth>"
    exit 1
fi

FILE_EXT=$1
DIR_PATH=$2
NUM_FILES=$3
MAX_DEPTH=$4

#### TODO make it find the most recent 'n' files

find ${DIR_PATH} -maxdepth ${MAX_DEPTH} -name "*.${FILE_EXT}" -printf '%T@ %p\n' | sort -k1,1nr | head -n${NUM_FILES} | cut -d' ' -f2-
