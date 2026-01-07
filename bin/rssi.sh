#!/bin/bash
# Script to return the RSSI of a local WiFi interface

#### TODO make a generalized version of this that takes args for: SSID, freq, RX, TX, signal, rx bitrate, tx bitrate, etc.

INTF="${1:-wlan0}"

echo $(iw dev ${INTF} link | grep -i signal | cut -d ":" -f 2)
