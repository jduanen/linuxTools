#!/bin/bash
#
# Script to run Angry IP Scanner tool
#
# Usage: ipscan.sh [<ipRange> [<outFile> [<options]]]

IP_RANGE=${1:-192.168.166.0 192.168.166.255}
OUTFILE=${2:-/tmp/ipscan.txt}
OPTS=${3:-sq}

java -jar ${HOME}/Code2/ipscan/build/libs/ipscan-linux64*.jar -f:range ${IP_RANGE} -o ${OUTFILE} -${OPTS}
