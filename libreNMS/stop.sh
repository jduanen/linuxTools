#!/bin/bash
#
# Script to stop and remove libreNMS docker containers

COMPOSE_FILE="${HOME}/Code/linuxTools/libreNMS/librenms/docker-master/examples/compose/compose.yml"

docker compose -f ${COMPOSE_FILE} down
