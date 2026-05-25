#!/usr/bin/env bash
# Network - Show Open Connections
# Lists all established TCP connections with remote address and associated process.
echo "=== Established TCP connections ==="
ss -tnp state established
echo ""
echo "Total: $(ss -tnp state established | grep -c ESTAB || echo 0) connection(s)"
exit 0
