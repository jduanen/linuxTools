#!/bin/bash
# Script that streams from a tty to the console

stty raw -echo < /dev/tty$1
cat < /dev/tty$1
