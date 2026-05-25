#!/usr/bin/env bash
# Collect - Timezone
# Reports the system timezone and current time.
echo "Timezone: $(timedatectl show --property=Timezone --value 2>/dev/null || cat /etc/timezone 2>/dev/null)"
echo "Current time: $(date)"
exit 0
