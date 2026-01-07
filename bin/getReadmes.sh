#!/bin/bash
#
# A script to find all the readme files under a given directory, and
# create symlinks to them in the current directory.
#

if [ $# -eq 0 ]; then
    echo "Usage: $0 <path>"
    exit 1
fi

searchPath="${1%/}"  # ensure path doesn't end with a slash

# find all README* files (case-insensitive) and create symlinks
find "$searchPath" -type f -iname "README*" -print0 | while IFS= read -r -d '' file; do
    relativePath="${file#$searchPath/}"
    newFilename="${relativePath//\//_}"
    ln -s -f "$file" "$newFilename"
    echo "Created symlink $newFilename -> $file"
done
