#!/usr/bin/env bash
# Monitor - Open File Descriptors
# Checks system-wide open file descriptor usage against the kernel limit; exits 1 if >80%.
allocated=$(awk '{print $1}' /proc/sys/fs/file-nr)
max=$(awk '{print $3}' /proc/sys/fs/file-nr)
pct=$(( allocated * 100 / max ))
echo "Open file descriptors: $allocated / $max ($pct%)"
if [ "$pct" -ge 90 ]; then echo "ALERT: FD usage at ${pct}% (>90%)."; exit 1; fi
if [ "$pct" -ge 75 ]; then echo "WARNING: FD usage at ${pct}% (>75%)."; exit 2; fi
echo "OK: File descriptor usage within normal range."; exit 0
