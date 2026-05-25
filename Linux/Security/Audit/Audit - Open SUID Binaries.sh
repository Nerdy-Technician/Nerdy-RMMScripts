#!/usr/bin/env bash
# Audit - Open SUID Binaries
# Lists all SUID/SGID binaries; flags any not in a known-safe list.
known_safe=(
  /usr/bin/sudo /usr/bin/passwd /usr/bin/su /usr/bin/newgrp
  /usr/bin/chsh /usr/bin/chfn /usr/bin/gpasswd /usr/bin/pkexec
  /bin/mount /bin/umount /bin/ping /usr/bin/ping
)
echo "=== SUID/SGID binaries found ==="
found=$(find / -xdev -type f \( -perm -4000 -o -perm -2000 \) 2>/dev/null)
echo "$found"
echo ""
unknown=()
while IFS= read -r f; do
  is_known=false
  for k in "${known_safe[@]}"; do [ "$f" = "$k" ] && is_known=true && break; done
  $is_known || unknown+=("$f")
done <<< "$found"
if [ "${#unknown[@]}" -gt 0 ]; then
  echo "WARNING: ${#unknown[@]} potentially unexpected SUID/SGID binary(ies):"
  printf '  %s\n' "${unknown[@]}"
  exit 2
fi
echo "OK: All SUID/SGID binaries are in the known-safe list."; exit 0
