#!/bin/bash
# Script to update the Portainer agent instance

docker stop portainer
docker rm portainer
docker pull portainer/portainer-ce:latest

SCRIPT_PATH=$(realpath "$0")
${SCRIPT_PATH}/startPortainerAgent.sh
