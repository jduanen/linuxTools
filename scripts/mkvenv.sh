#!/bin/bash
# Script to create a new virtualenvwrapper venv

if [ $# -ne 2 ]; then
    echo "Usage: $0 <prompt> <venvName>"
    exit 1
fi

PROMPT=$1
VENV_NAME=$2

source /usr/share/virtualenvwrapper/virtualenvwrapper.sh

mkvirtualenv --python=`which python3` --prompt=${PROMPT} ${VENV_NAME}
