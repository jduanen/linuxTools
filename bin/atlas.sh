#!/bin/bash
# Script to start up Atlas to monitor containers
#
# Usage: <browser> http://gpuserver1.lan:8888
#
# TODO consider running it continuously

docker run -d --rm\
  --name atlas \
  --network=host \
  --cap-add=NET_RAW \
  --cap-add=NET_ADMIN \
  -v /var/run/docker.sock:/var/run/docker.sock \
  keinstien/atlas:latest
