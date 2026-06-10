#!/bin/bash
#
# Script to set up chrony time sync on an Ubuntu machine

sudo apt update
sudo apt install chrony
sudo systemctl enable --now chrony

# point at NTP server
sudo cp /etc/chrony/chrony.conf /etc/chrony/chrony.conf.orig
sudo cat - >> /etc/chrony/chrony.conf
'''
# use gpuServer1.local as server
server 192.168.166.13 iburst

# allow network corrections if needed
allow 192.168.166.0/24
'''

# restart and verify
sudo systemctl restart chrony
sudo systemctl status chrony
chronyc sources -v
timedatectl

# set the system timezone
timedatectl list-timezones | grep -i "Los_Angeles"
sudo timedatectl set-timezone America/Los_Angeles

# verify it
timedatectl status
