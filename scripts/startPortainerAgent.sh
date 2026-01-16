#!/bin/bash
#
# Script to start Portainer Agent on a machine to be monitored.
# This is a lightweight agent that runs on machines to be monitored.
#
# Remote Use: <browser> https://<primaryHostName>:9443

docker run -d -p 9001:9001 --name portainer_agent --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /var/lib/docker/volumes:/var/lib/docker/volumes \
  portainer/agent:latest
