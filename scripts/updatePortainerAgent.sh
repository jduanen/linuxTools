#!/bin/bash
# Script to update the Portainer agent instance


SCRIPT_PATH=$(cd "$(dirname "$0")" && pwd)

${SCRIPT_PATH}/stopPortainerAgent.sh

docker pull portainer/portainer-ce:latest

${SCRIPT_PATH}/startPortainerAgent.sh
