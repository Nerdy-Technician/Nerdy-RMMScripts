#!/usr/bin/env bash
# Software Management - Check Held Packages
# Lists packages held at their current version; exits 1 if any found.
held=$(apt-mark showhold 2>/dev/null)
if [ -n "$held" ]; then
  echo "ALERT: Held packages found:"
  echo "$held"
  exit 1
fi
echo "OK: No packages are held."; exit 0
