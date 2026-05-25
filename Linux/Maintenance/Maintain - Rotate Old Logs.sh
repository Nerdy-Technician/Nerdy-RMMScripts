#!/usr/bin/env bash
# Maintain - Rotate Old Logs
# Compresses log files older than 7 days in /var/log; removes files older than 30 days.
find /var/log -type f -name "*.log" -mtime +7 ! -name "*.gz" -exec gzip -f {} \; 2>/dev/null
find /var/log -type f -name "*.gz" -mtime +30 -delete 2>/dev/null
echo "Log rotation complete."; exit 0
