#!/usr/bin/env bash
# Network - Traceroute Default GW
# Runs a traceroute to the default gateway to check routing path.
gw=$(ip route | awk '/default/{print $3; exit}')
if [ -z "$gw" ]; then echo "ERROR: No default gateway found."; exit 1; fi
echo "Default gateway: $gw"
traceroute -m 5 "$gw" 2>/dev/null || tracepath -m 5 "$gw" 2>/dev/null
exit 0
