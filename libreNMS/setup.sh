#!/bin/bash
#
# Script to setup libreNMS to scan and install SNMP devices

IP_ADDRS="192.168.166.0/24"

sudo docker compose exec --user librenms librenms lnms config:set nets.+ \'${IP_ADDRS}\'
sudo docker compose exec --user librenms librenms lnms config:set snmp.community.+ public
sudo docker compose exec --user librenms librenms /opt/librenms/snmp-scan.py ${IP_ADDRS}
sudo docker compose exec --user librenms librenms ./lnms discovery
