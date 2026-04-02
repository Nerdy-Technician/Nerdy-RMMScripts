#!/usr/bin/env bash
# Audit - Sudoers Config
# Enumerates sudoers entries including drop-in files. Exits 1 if NOPASSWD is found.
NOPASSWD=0
echo "=== /etc/sudoers (non-comment entries) ==="
grep -v "^[[:space:]]*#\|^[[:space:]]*$" /etc/sudoers 2>/dev/null || echo "(not readable)"
for f in /etc/sudoers.d/*; do
  [ -f "$f" ] || continue
  echo "=== $f ==="
  grep -v "^[[:space:]]*#\|^[[:space:]]*$" "$f" 2>/dev/null
done
if grep -rq "NOPASSWD" /etc/sudoers /etc/sudoers.d/ 2>/dev/null; then
  echo "WARNING: NOPASSWD entries detected in sudoers"; NOPASSWD=1
fi
[ "$NOPASSWD" -eq 1 ] && exit 1; exit 0
