#!/usr/bin/env bash
# Audit - Login History
# Shows recent successful logins and currently logged-in users.
echo "=== Currently logged in ==="
who
echo ""
echo "=== Last 20 logins ==="
last -n 20
exit 0
