#!/usr/bin/env bash
# Check - NTP Sync
# Verifies clock synchronization via chrony or systemd-timesyncd. Exits 1 if not synced.
if command -v chronyc &>/dev/null; then
  TRACKING=$(chronyc tracking 2>/dev/null)
  OFFSET=$(echo "$TRACKING" | awk '/System time/ {print $4, $5}')
  REF=$(echo "$TRACKING" | awk '/Reference ID/ {print $4, $5}')
  if echo "$TRACKING" | grep -q "^Reference ID.*0\.0\.0\.0"; then
    echo "ALERT: chrony not synced (no reference)"; exit 1
  fi
  echo "NTP synced (chrony). Ref: $REF | Offset: $OFFSET"; exit 0
elif command -v timedatectl &>/dev/null; then
  SYNCED=$(timedatectl show --property=NTPSynchronized --value 2>/dev/null)
  if [ "$SYNCED" != "yes" ]; then echo "ALERT: NTP not synchronized (timedatectl)"; exit 1; fi
  echo "NTP synced (systemd-timesyncd)"; exit 0
else
  echo "WARNING: No NTP client found (chrony/timedatectl)"; exit 2
fi
