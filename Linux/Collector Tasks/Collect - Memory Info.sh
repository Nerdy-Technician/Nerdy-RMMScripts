#!/usr/bin/env bash
# Collect - Memory Info
# Reports total, used, free, and swap memory.
free -h
echo ""
echo "Total RAM: $(awk '/MemTotal/{printf "%.1f GB\n", $2/1024/1024}' /proc/meminfo)"
exit 0
