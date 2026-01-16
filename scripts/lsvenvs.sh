#!/bin/bash
# Script to list names of virtualenvwrapper venvs

source /usr/share/virtualenvwrapper/virtualenvwrapper.sh
export PATH=${PATH}:/usr/share/
lsvirtualenv | sed -e 's/^=*$//' -e '/^$/d'
