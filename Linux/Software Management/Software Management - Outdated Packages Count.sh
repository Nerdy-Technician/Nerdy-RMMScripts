#!/usr/bin/env bash
# Software Management - Outdated Packages Count
# Reports count of packages with available updates; exits 1 if >50, 2 if >10.
apt-get update -qq 2>/dev/null
count=$(apt list --upgradable 2>/dev/null | grep -c upgradable || echo 0)
echo "Packages with available updates: $count"
apt list --upgradable 2>/dev/null
if [ "$count" -gt 50 ]; then echo "ALERT: $count packages outdated (>50)."; exit 1; fi
if [ "$count" -gt 10 ]; then echo "WARNING: $count packages outdated (>10)."; exit 2; fi
echo "OK: Updates within acceptable count."; exit 0
