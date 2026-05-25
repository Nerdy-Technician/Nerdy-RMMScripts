#!/usr/bin/env bash
# Check - Last Reboot
# Reports last reboot time and uptime; exits 1 if uptime exceeds 90 days.
THRESHOLD_DAYS=90
uptime_seconds=$(awk '{print int($1)}' /proc/uptime)
uptime_days=$(( uptime_seconds / 86400 ))
last_boot=$(who -b | awk '{print $3, $4}')
echo "Last reboot: $last_boot"
echo "Uptime: ${uptime_days} day(s)"
if [ "$uptime_days" -gt "$THRESHOLD_DAYS" ]; then
  echo "ALERT: System has been up for ${uptime_days} days (>${THRESHOLD_DAYS})."; exit 1
fi
echo "OK: Uptime within acceptable range."; exit 0
