#!/usr/bin/env bash
# Monitor - Systemd Failed Units
# Reports count of failed systemd units. Exits 1 if any are found.
FAILED=$(systemctl --failed --no-legend --no-pager 2>/dev/null | grep -c "failed" || echo 0)
if [ "$FAILED" -gt 0 ]; then
  echo "ALERT: $FAILED failed systemd unit(s):"
  systemctl --failed --no-legend --no-pager 2>/dev/null
  exit 1
fi
echo "All systemd units healthy (0 failed)"; exit 0
