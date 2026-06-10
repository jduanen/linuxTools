#!/usr/bin/env python3
import subprocess
import time
import json
from pathlib import Path

KNOWN_DEVICES = set()  # Load your known MACs here
SCAN_FILE = Path("known_devices.json")

def scan_lan():
    """Scan LAN and return MAC:IP pairs"""
    result = subprocess.run(['nmap', '-sn', '192.168.1.0/24', 
                           '--min-parallelism', '100'], 
                          capture_output=True, text=True)
    devices = {}
    for line in result.stdout.splitlines():
        if 'Nmap scan report' in line:
            ip = line.split()[-1]
        elif 'MAC Address:' in line:
            mac = line.split('MAC Address: ')[1].split()[0]
            devices[mac] = ip
    return devices

def load_known():
    if SCAN_FILE.exists():
        with open(SCAN_FILE) as f:
            return set(json.load(f))
    return set()

def save_known(devices):
    with open(SCAN_FILE, 'w') as f:
        json.dump(list(devices), f)

# Main loop
known_macs = load_known()
while True:
    devices = scan_lan()
    new_devices = set(devices) - known_macs
    
    for mac in new_devices:
        ip = devices[mac]
        print(f"🚨 NEW DEVICE: {mac} at {ip}")
    
    known_macs.update(devices.keys())
    save_known(known_macs)
    time.sleep(30)  # Scan every 30s
