#!/usr/bin/env bash
# Maintain - Trim SSD
# Runs fstrim on all mounted filesystems that support TRIM; reports results.
if ! command -v fstrim &>/dev/null; then
  echo "ERROR: fstrim not available."; exit 1
fi
fstrim --all --verbose 2>&1
exit 0
