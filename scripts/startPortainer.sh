#!/bin/bash
#
# Script to start Portainer in a container on a host linux machine.
# This is the primary manager Portainer server (other hosts run lightweight
#  Portainer Agents).
#
# Remote Use: <browser> https://<primaryHostName>:9443

docker run -d \
  -p 9443:9443 \
  -p 8001:8001 \
  --name portainer \
  --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v portainer_data:/data \
  --shm-size=1gb \
  portainer/portainer-ce:lts \
  --tunnel-port 8001
