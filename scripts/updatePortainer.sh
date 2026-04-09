#!/bin/bash
#
# Script to update the local Portainer instance

SCRIPT_PATH=$(cd "$(dirname "$0")" && pwd)

${SCRIPT_PATH}/stopPortainer.sh

docker pull portainer/portainer-ce:latest

${SCRIPT_PATH}/startPortainer.sh
