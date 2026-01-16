#!/bin/bash
#
# Script to start Portainer Agent on a machine to be monitored.
# This is a lightweight agent that runs on machines to be monitored.
#
# Add agent as remote environment to the manager.
# On the Portainer WebUI, got to Environments->Docker standalone->Agent and
#  give remote the host's name and agent URL (http://gpuServer1.lan:9001), then
#  click Connect.

docker run -d -p 9001:9001 --name portainer_agent --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /var/lib/docker/volumes:/var/lib/docker/volumes \
  portainer/agent:latest
