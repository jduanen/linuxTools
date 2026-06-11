#!/bin/bash
#
# Script to enable SNMP on a Linux device

#### TODO look at /etc/*release* or uname and figure out what OS and version this is and don't take cli arg

OS_VERSION=${1}

COMMUNITY="homecommunity"
SUPPORTED_OS_VERSIONS="bookworm, ubuntu_24.04"

raspi() {
	# install snmpd packages
	sudo apt update
	sudo apt install snmpd snmp snmp-mibs-downloader -y

	# backup the snmp config file and enable mib loading
	sudo cp /etc/snmp/snmp.conf /etc/snmp/snmp.conf.orig
	sudo sed -i 's/^mibs *:/#mibs :/' /etc/snmp/snmp.conf

	# backup the snmpd config file and enable listening on all ipv4 and ipv6 interfaces
	sudo cp /etc/snmp/snmpd.conf /etc/snmp/snmpd.conf.orig
	sudo sed -i 's/^agentaddress *127.0.0.1,\[::1\]/agentaddress  udp:161,udp6:161/' /etc/snmp/snmpd.conf

	# grant SNMP access to all users with $1 community from any IP and remove the -V option
	sudo sed -i "s/^rocommunity *public *default *-V *systemonly/rocommunity $1 default/" /etc/snmp/snmpd.conf
	sudo sed -i "s/^rocommunity6 *public *default *-V *systemonly/rocommunity6 $1 default/" /etc/snmp/snmpd.conf

	# restart snmpd
	sudo systemctl restart snmpd
	sudo systemctl enable snmpd
}

ubuntu() {
	# install snmpd packages
	sudo apt update
	sudo apt install snmpd snmp libsnmp-dev snmp-mibs-downloader -y

	# save a backup of the snmp config file and enable MIB loading
	sudo cp /etc/snmp/snmp.conf /etc/snmp/snmp.conf.orig
	sudo sed -i 's/^mibs *:/#mibs :/' /etc/snmp/snmp.conf

    # backup the snmpd default file and enable things
    sudo cp /etc/default/snmpd /etc/default/snmpd.orig
    echo "SNMPDOPTS='-Lsd -Lf /dev/null -u Debian-snmp -g Debian-snmp -I -smux -p /run/snmpd.pid 0.0.0.0'" | sudo tee -a /etc/default/snmpd

	# save a backup of the snmpd config file and enable listening on all ipv4 and ipv6 interfaces
	sudo cp /etc/snmp/snmpd.conf /etc/snmp/snmpd.conf.orig
	sudo sed -i 's/^agentaddress *127.0.0.1,\[::1\]/agentaddress  udp:161,udp6:161/' /etc/snmp/snmpd.conf

	# set community string to $1 and remove the -V option
	sudo sed -i "s/^rocommunity *public *default *-V *systemonly/rocommunity $1 default/" /etc/snmp/snmpd.conf
	sudo sed -i "s/^rocommunity6 *public *default *-V *systemonly/rocommunity6 $1 default/" /etc/snmp/snmpd.conf

	# restart snmpd
	sudo systemctl restart snmpd
	sudo systemctl enable snmpd
}

case "$OS_VERSION" in
    "bookworm")
        raspi ${COMMUNITY}
        ;;
    "trixie")
        raspi ${COMMUNITY}
        ;;
    "ubuntu_24.04")
        ubuntu ${COMMUNITY}
        ;;
    * )
        echo "Invalid OS Version - must be one of: $SUPPORTED_OS_VERSIONS"
        exit 1
        ;;
esac

# check listening on all interfaces locally
sudo netstat -lnup | grep 161  # should show: 0.0.0.0:161, not just: 127.0.0.1:161

# test SNMP locally
snmpwalk -v 2c -c ${COMMUNITY} localhost sysDescr.0  # should return device info
