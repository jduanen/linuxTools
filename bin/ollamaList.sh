#!/bin/bash
#
# Script to search for models that can be pulled by an ollama container
#

#### TODO parse more of the response page and extract the model sizes (e.g., '20b, 120b')

USAGE="$0 <modelPrefix>"  ## matches models starting with the given string

####curl -s https://registry.ollama.ai/v2/library/ | jq -r 'keys[]'

if [ $# -eq 0 ]; then
    # get all of the models and sort them alphabetically
    curl -s https://ollama.com/library | grep -oP 'href="/library/[^"/]+' | sed 's|href="/library/||; s|/.*||g' | sort -u
elif [ $# -eq 1 ]; then
    MODEL_PREFIX=$1
    curl -s https://ollama.com/library | grep -oP 'href="/library/'${MODEL_PREFIX}'[^"/]+' | sed 's|href="/library/||; s|/.*||g' | sort -u
else
    echo "ERROR: extra arguments"
    echo ${USAGE}
    exit 1
fi
