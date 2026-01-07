#!/bin/bash
echo "Removing CUPS..."
sudo systemctl --reverse list-dependencies cups.*
sudo systemctl stop avahi-daemon.service
sudo systemctl mask avahi-daemon.service
sudo systemctl mask avahi-daemon.socket
sudo systemctl mask cups.service cups.socket cups.path
sudo systemctl mask cups-browserd.service
#### FIXME don't append if "manual" already appears in the file
sudo echo "manual" >> /etc/init/cups.override
#### FIXME don't append if "manual" already appears in the file
sudo echo "manual" >> /etc/init/cups-browsed.override
sudo apt-get purge --auto-remove cups
echo "CUPS Removed"
