#!/bin/bash
# Set displays back to original settings on KDE system after ending a moonlight session.
# you can use 'kscreen-doctor -o' to verify your current values
# Set in sunshine -> config -> general -> undo command
# /path/to/scripts/moonlight-off.sh

set -e

# Get params or set defaults.  Only defaults are used with recommended config
width=${1:-2560}
height=${2:-1440}
refresh_rate=${3:-60}

echo "Setting refresh rate ${width}x${height}@${refresh_rate}"

# Set physical monitors on DP-1/2 to desired values
# WAYLAND_DISPLA=wayland-0 is required to run from ssh/headless while KDE is running (or you need to fix monitors when moonlight crashed?)

WAYLAND_DISPLAY=wayland-0 kscreen-doctor \
	output.DP-1.enable \
	output.DP-1.scale.1 \
	output.DP-1.position.0,0 \
	output.DP-1.priority.3 \
    output.DP-2.enable \
	output.DP-2.scale.1 \
	output.DP-2.position.2560,0 \
	output.DP-2.priority.2 
WAYLAND_DISPLAY=wayland-0 kscreen-doctor \
    output.DP-3.enable \
    output.DP-3.mode.${width}x${height}@${refresh_rate} \
    output.DP-3.scale.1 \
    output.DP-3.position.2560,0 \
	output.DP-3.priority.1
