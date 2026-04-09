#!/bin/bash
#
# Script to update the local Portainer agent instance

SCRIPT_PATH=$(cd "$(dirname "$0")" && pwd)

${SCRIPT_PATH}/stopPortainerAgent.sh

docker pull portainer/agent:latest

${SCRIPT_PATH}/startPortainerAgent.sh
