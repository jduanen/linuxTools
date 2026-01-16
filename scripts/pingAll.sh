#!/bin/bash
# Script to ping all of IPAs in a class C subnet and print active nodes

BASE="192.168.166"

for I in {0..255}; do
	IPA="${BASE}.${I}"
	if ping -c 1 ${IPA} > /dev/null 2>&1; then
		echo -n "${IPA}: "
        arp ${IPA} | tail -n 1 | tr -s '[ \t]' ' '
    fi
done
