#!/bin/bash
#
# Script to connect to the libreNMS docker container

COMPOSE_FILE="${HOME}/Code/linuxTools/libreNMS/librenms/docker-master/examples/compose/compose.yml"

docker compose -f ${COMPOSE_FILE} exec librenms bash
