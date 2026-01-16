#!/bin/bash
#
# Script to update the pip packages in a venv
#
# N.B. you have to be in the desired venv: e.g., 'workon ESPHOME'

pip list --outdated | grep "pip" > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "$0: pip needs to be updated"
    python -m pip install --upgrade pip
fi

echo "$0: Packages that need to be updated"
pip list --outdated
echo ""

echo "$0: Updating out-of-date packages"
pip list --outdated --disable-pip-version-check | tail -n +3 | awk '{print $1;}' | tr '\n' ' ' | xargs pip install --upgrade
