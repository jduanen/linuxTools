#!/bin/bash
#
# Script to discover and add a device to libreNMS

if [ $# -ne 1 ]; then
    echo "Usage: $0 <deviceNameOrAddress>"
    exit 1
fi

COMPOSE_FILE="${HOME}/Code/linuxTools/libreNMS/librenms/docker-master/examples/compose/compose.yml"

DEVICE=${1}
COMMUNITY="homecommunity"

docker compose -f ${COMPOSE_FILE} exec --user librenms librenms ./lnms device:add --v2c -c ${COMMUNITY} ${DEVICE}
docker compose -f ${COMPOSE_FILE} exec --user librenms librenms ./lnms device:discover ${DEVICE}
