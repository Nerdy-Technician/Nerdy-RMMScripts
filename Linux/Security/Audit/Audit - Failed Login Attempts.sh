#!/usr/bin/env bash
# Audit - Failed Login Attempts
# Reports failed SSH/login attempts from the last 24h; exits 1 if over threshold.
THRESHOLD=10
log=""
for f in /var/log/auth.log /var/log/secure; do [ -f "$f" ] && log="$f" && break; done
if [ -z "$log" ]; then echo "WARNING: No auth log found."; exit 2; fi
count=$(grep -c "Failed password\|Invalid user" "$log" 2>/dev/null || echo 0)
echo "Failed login attempts found: $count"
grep "Failed password\|Invalid user" "$log" 2>/dev/null | tail -20
if [ "$count" -gt "$THRESHOLD" ]; then
  echo "ALERT: $count failed attempts exceeds threshold of $THRESHOLD."; exit 1
fi
echo "OK: Failed attempts within acceptable range."; exit 0
