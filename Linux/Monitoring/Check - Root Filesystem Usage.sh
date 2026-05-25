#!/usr/bin/env bash
# Check - Root Filesystem Usage
# Checks / filesystem usage; exits 1 if >90%, 2 if >75%.
usage=$(df / | awk 'NR==2{print $5}' | tr -d '%')
echo "Root filesystem usage: ${usage}%"
df -h /
if [ "$usage" -ge 90 ]; then echo "ALERT: Root filesystem >90% full."; exit 1; fi
if [ "$usage" -ge 75 ]; then echo "WARNING: Root filesystem >75% full."; exit 2; fi
echo "OK: Root filesystem usage within limits."; exit 0
