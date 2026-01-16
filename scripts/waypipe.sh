#!/bin/bash
# Script to remotely execute a program on a linux machine running wayland
# Make sure waypipe is installed on both local and remote machines

USR="jdn"
REM_HOST=${1}
APPL=${2}

if [ $# -ne 2 ]; then
    echo "Usage: $0 <remoteHost> <appl>"
    exit 1
fi

/usr/bin/waypipe -c lz4=9 ssh ${USR}@${REM_HOST}.lan ${APPL}
