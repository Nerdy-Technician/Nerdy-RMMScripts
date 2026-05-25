#!/usr/bin/env bash
# Cron - Disk Clean Entry
# Checks for a weekly disk cleanup cron entry; exits 1 if missing.
if crontab -l 2>/dev/null | grep -q "Maintain - Disk Clean\|apt clean\|apt autoremove"; then
  echo "OK: Disk cleanup cron entry found."; exit 0
fi
echo "WARNING: No disk cleanup cron entry found."
echo "Suggested entry: 0 3 * * 0 /path/to/Maintain - Disk Clean.sh >> /var/log/disk-clean.log 2>&1"
exit 1
