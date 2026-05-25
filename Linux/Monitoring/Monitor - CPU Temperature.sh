#!/usr/bin/env bash
# Monitor - CPU Temperature
# Reports CPU temperature via sensors; exits 1 if >85°C, 2 if >70°C.
if ! command -v sensors &>/dev/null; then
  echo "WARNING: lm-sensors not installed (apt install lm-sensors)."; exit 2
fi
output=$(sensors 2>/dev/null)
echo "$output"
max_temp=$(echo "$output" | grep -oP '\+\K[0-9]+(?=\.[0-9]+°C)' | sort -n | tail -1)
if [ -z "$max_temp" ]; then echo "WARNING: Could not parse temperature."; exit 2; fi
if [ "$max_temp" -ge 85 ]; then echo "ALERT: CPU temp ${max_temp}°C exceeds 85°C."; exit 1; fi
if [ "$max_temp" -ge 70 ]; then echo "WARNING: CPU temp ${max_temp}°C exceeds 70°C."; exit 2; fi
echo "OK: CPU temp ${max_temp}°C within normal range."; exit 0
