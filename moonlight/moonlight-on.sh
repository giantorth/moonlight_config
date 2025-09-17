#!/bin/bash
# This script is for a KDE Linux system with 2 real displays and a third display created by a dummy plug
# Configure this script as a "do command" in the general tab of sunshine configuration
# bash -c "/path/to/scripts/moonlight-on.sh \"${SUNSHINE_CLIENT_WIDTH}\" \"${SUNSHINE_CLIENT_HEIGHT}\" \"${SUNSHINE_CLIENT_FPS}\""
set -e

# Get params with fallback defaults
width=${1:-1920}
height=${2:-1080}
refresh_rate=${3:-60}

echo "Setting screen ${width}x${height}@${refresh_rate}" 

#Turn of physical displays
kscreen-doctor \
	output.DP-1.disable \
	output.DP-2.disable
# Configfigure dummy plug in port 3 to input values.  WIll silently fail if not supported by plug.
kscreen-doctor \
	output.DP-3.enable \
	output.DP-3.mode.${width}x${height}@${refresh_rate} \
	output.DP-3.scale.1 \
	output.DP-3.position.0,0 \
	output.DP-3.hdr.enable

