#!/bin/bash
#
# Script to stop and remove the Portainer container

docker stop portainer_agent
docker rm portainer_agent
