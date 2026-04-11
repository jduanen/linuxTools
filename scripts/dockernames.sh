#!/bin/bash
#
# Script to print names of local containers

docker ps --format "{{.Names}}"
