#!/usr/bin/env bash
# Audit - Listening Services
# Lists processes bound to all interfaces (0.0.0.0 or ::). Exits 0 with table output.
echo "Services listening on all interfaces:"
if command -v ss &>/dev/null; then
  ss -tlnp 2>/dev/null | awk 'NR==1 || /0\.0\.0\.0|::/'
else
  netstat -tlnp 2>/dev/null | awk 'NR<=2 || /0\.0\.0\.0|::/'
fi
exit 0
