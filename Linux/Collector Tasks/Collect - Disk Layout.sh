#!/usr/bin/env bash
# Collect - Disk Layout
# Reports disk partitions, mount points, filesystem types, and usage.
echo "=== Block devices ==="
lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINT
echo ""
echo "=== Disk usage ==="
df -hT --exclude-type=tmpfs --exclude-type=devtmpfs
exit 0
