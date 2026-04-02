#!/usr/bin/env bash
# Check - Fail2ban Status
# Reports fail2ban service state and active jail ban counts. Exits 1 if service is down, 2 if not installed.
if ! command -v fail2ban-client &>/dev/null; then
  echo "WARNING: fail2ban not installed"; exit 2
fi
if ! systemctl is-active --quiet fail2ban 2>/dev/null; then
  echo "ALERT: fail2ban service is not running"; exit 1
fi
echo "fail2ban is active. Active jails:"
fail2ban-client status 2>/dev/null | awk -F: '/Jail list/ {gsub(/[ \t]/, "", $2); n=split($2,a,","); for(i=1;i<=n;i++) print a[i]}' | while read -r jail; do
  banned=$(fail2ban-client status "$jail" 2>/dev/null | awk '/Currently banned/ {print $NF}')
  echo "  $jail: $banned banned"
done
exit 0
