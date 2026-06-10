#!/bin/bash
#
# Script to scan a network and add devices that respond to nmap pings to libreNMS
#
# Usage: scan.sh ????

LIBRENMS_SUBNET="192.168.166.0/24"
COMPOSE_FILE="${HOME}/Code/linuxTools/libreNMS/librenms/docker-master/examples/compose/compose.yml"

DOCKER_COMPOSE_CMD="sudo docker compose -f ${COMPOSE_FILE} exec --user librenms --interactive=false librenms"

echo "=== Step 1: Run nmap scan ==="
echo "Scanning: $LIBRENMS_SUBNET"

# run nmap ping sweep (no port scan, just host discovery)
nmap_output=$(nmap -sn $LIBRENMS_SUBNET 2>/dev/null)

# extract IPs from nmap output
ip_list=$(echo "$nmap_output" | grep "Nmap scan report" | awk '{print $5}')

if [ -z "$ip_list" ]; then
    echo "ERROR: No devices found in nmap scan"
    exit 1
fi

# save to temporary file
temp_file="/tmp/nmap_ips_$(date +%s).txt"
echo "$ip_list" > "$temp_file"
echo "Found $(echo "$ip_list" | wc -l) devices"
echo "IP list saved to: $temp_file"

echo ""
echo "=== Step 2: Add ping-only devices to LibreNMS ==="

added=0
failed=0

while read ip; do
    if [ -z "$ip" ]; then
        continue
    fi
    
    echo "Adding ping-only device: $ip"
    
    # add device to LibreNMS (ping-only mode)
    if $DOCKER_COMPOSE_CMD ./lnms device:add --ping-only $ip >/dev/null 2>&1; then
        echo "  ✓ Added: $ip"
        added=$((added + 1))
    else
        echo "  ✗ Failed: $ip (may already exist)"
        failed=$((failed + 1))
    fi
done <<< "$ip_list"

echo ""
echo "=== Summary ==="
echo "Successfully added: $added devices"
echo "Failed to add: $failed devices"
echo ""

# add OS icons
echo "=== Discover OS Types ==="
${DOCKER_COMPOSE_CMD} ./lnms device:discover all

# scan for SNMP-enabled devices
sudo docker compose exec --user librenms librenms /opt/librenms/snmp-scan.py -v -l --ping-fallback ${LIBRENMS_SUBNET}

# Clean up temp file
rm -f "$temp_file"
