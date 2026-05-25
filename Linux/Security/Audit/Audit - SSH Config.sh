#!/usr/bin/env bash
# Audit - SSH Config
# Checks sshd_config for common insecure settings; exits 1 if issues found.
cfg="/etc/ssh/sshd_config"
issues=()
grep -qiE "^PermitRootLogin\s+yes" "$cfg" 2>/dev/null && issues+=("PermitRootLogin is yes")
grep -qiE "^PasswordAuthentication\s+yes" "$cfg" 2>/dev/null && issues+=("PasswordAuthentication is yes")
grep -qiE "^PermitEmptyPasswords\s+yes" "$cfg" 2>/dev/null && issues+=("PermitEmptyPasswords is yes")
grep -qiE "^X11Forwarding\s+yes" "$cfg" 2>/dev/null && issues+=("X11Forwarding is yes")
if [ "${#issues[@]}" -gt 0 ]; then
  echo "ALERT: SSH config issues detected:"
  for i in "${issues[@]}"; do echo "  - $i"; done
  exit 1
fi
echo "OK: SSH config looks secure."; exit 0
