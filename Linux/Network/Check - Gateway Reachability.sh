#!/usr/bin/env bash
# Check - Gateway Reachability
# Pings the default gateway; exits 1 if unreachable.
gw=$(ip route | awk '/default/{print $3; exit}')
if [ -z "$gw" ]; then echo "ERROR: No default gateway found."; exit 1; fi
echo "Pinging default gateway: $gw"
if ping -c 3 -W 2 "$gw" &>/dev/null; then
  echo "OK: Gateway $gw is reachable."; exit 0
fi
echo "ALERT: Gateway $gw is unreachable."; exit 1
