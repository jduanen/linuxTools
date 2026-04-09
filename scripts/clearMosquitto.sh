#!/bin/bash
#
# Script to clear all of the retained messages from a Mosquitto broker

# list all retained msgs, pipe them to pub empty retained
mosquitto_sub -t '#' --retained-only -F '%t' | while read topic; do
  mosquitto_pub -t "$topic" -n -r
done
