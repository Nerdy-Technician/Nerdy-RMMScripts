#!/usr/bin/env bash
# Monitor - OOM Kill Events
# Checks journald for OOM kill events in the last HOURS (default 1). Exits 1 if found.
HOURS="${HOURS:-1}"
COUNT=$(journalctl -k --since "${HOURS} hours ago" --no-pager 2>/dev/null | grep -c "Killed process" || echo 0)
if [ "$COUNT" -gt 0 ]; then
  echo "ALERT: $COUNT OOM kill event(s) in last ${HOURS}h:"
  journalctl -k --since "${HOURS} hours ago" --no-pager 2>/dev/null | grep "Killed process"
  exit 1
fi
echo "No OOM kills detected in last ${HOURS}h"; exit 0
