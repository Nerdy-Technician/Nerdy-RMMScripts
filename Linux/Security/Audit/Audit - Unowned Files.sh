#!/usr/bin/env bash
# Audit - Unowned Files
# Finds files with no valid owner or group on the filesystem; exits 1 if any found.
echo "Scanning for unowned files (may take a moment)..."
unowned=$(find / -xdev \( -nouser -o -nogroup \) -print 2>/dev/null)
if [ -n "$unowned" ]; then
  count=$(echo "$unowned" | wc -l)
  echo "ALERT: $count unowned file(s) found:"
  echo "$unowned" | head -50
  exit 1
fi
echo "OK: No unowned files found."; exit 0
