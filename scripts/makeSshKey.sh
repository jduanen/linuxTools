#!/bin/bash
#
# Script to create ssh key in ~/.ssh/
#
# To add to GitHub: Settings->SSH and GPG keys->New SSH key

KEY_FILE_PATH=${HOME}/.ssh/id_ed25519

if [ -f ${KEY_FILE_PATH} ]; then
	echo "ERROR: file exists (${KEY_FILE_PATH})"
	exit 1
fi

ssh-keygen -t ed25519 -C "duane.northcutt@gmail.com"

chmod 600 ${KEY_FILE_PATH}
chmod 644 ${KEY_FILE_PATH}.pub
