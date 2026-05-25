#!/usr/bin/env bash
# Audit - Passwd Shadow Permissions
# Verifies /etc/passwd and /etc/shadow have correct permissions; exits 1 if wrong.
issues=()
passwd_perms=$(stat -c "%a" /etc/passwd 2>/dev/null)
shadow_perms=$(stat -c "%a" /etc/shadow 2>/dev/null)
[ "$passwd_perms" != "644" ] && issues+=("/etc/passwd perms: $passwd_perms (expected 644)")
[ "$shadow_perms" != "640" ] && [ "$shadow_perms" != "000" ] && issues+=("/etc/shadow perms: $shadow_perms (expected 640 or 000)")
if [ "${#issues[@]}" -gt 0 ]; then
  echo "ALERT: Permission issues found:"
  for i in "${issues[@]}"; do echo "  - $i"; done
  exit 1
fi
echo "OK: /etc/passwd=$passwd_perms /etc/shadow=$shadow_perms"; exit 0
