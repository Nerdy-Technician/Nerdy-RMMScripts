#!/usr/bin/env bash
# Monitor - Active SSH Sessions
# Reports current active SSH sessions; exits 1 if count exceeds threshold.
THRESHOLD=10
sessions=$(ss -tnp | grep ':22' | grep ESTAB | wc -l)
echo "Active SSH sessions: $sessions"
ss -tnp | grep ':22' | grep ESTAB
if [ "$sessions" -gt "$THRESHOLD" ]; then
  echo "ALERT: $sessions active SSH sessions exceeds threshold of $THRESHOLD."; exit 1
fi
echo "OK: SSH session count within limits."; exit 0
