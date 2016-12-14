#!/bin/bash
cd

# Background.
xsetroot -solid black

# Any custom settings for this machine.
~/bin/xlocal || true

# Start dwm.
cmdterm "TODO warp to workspace" "cd env/dwm; make && ./dwm"

# Just in case.
xterm
