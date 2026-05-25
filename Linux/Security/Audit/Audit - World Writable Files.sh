#!/usr/bin/env bash
# Audit - World Writable Files
# Finds world-writable files outside /proc and /sys; alerts if any found.
count=$(find / -xdev -type f -perm -0002 \( ! -path "/proc/*" ! -path "/sys/*" \) 2>/dev/null | wc -l)
if [ "$count" -gt 0 ]; then
  echo "ALERT: $count world-writable file(s) found:"
  find / -xdev -type f -perm -0002 \( ! -path "/proc/*" ! -path "/sys/*" \) 2>/dev/null
  exit 1
fi
echo "OK: No world-writable files found."; exit 0
