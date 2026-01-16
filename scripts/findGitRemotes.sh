#!/bin/bash
# Script to find all of the git remotes below a given directory

CMD_TO_RUN="pwd | tr -d '\n' && echo -n ': ' && git remote -v | head -n 1 | tr ' ' '\t' | cut -f 2"

for dir in */; do
  if [ -d "$dir" ]; then
    # change into the subdirectory, run the command, and return to the original directory
    (cd "$dir" && eval "$CMD_TO_RUN" 2> /dev/null)
  fi
done

# use find command
##find . -maxdepth 1 -type d -not -name '.' -exec bash -c 'cd "$0" && eval "$1"' {} "$COMMAND_TO_RUN" \;
