#!/usr/bin/env bash
# Audit - SUID SGID Files
# Lists SUID/SGID binaries outside expected system paths. Exits 1 if unexpected files found.
EXPECTED=("/bin" "/sbin" "/usr/bin" "/usr/sbin" "/usr/lib" "/usr/libexec" "/usr/lib64")
FOUND=$(find / -xdev \( -perm -4000 -o -perm -2000 \) -type f 2>/dev/null)
TOTAL=$(echo "$FOUND" | grep -c . || echo 0)
UNEXPECTED=()
while IFS= read -r f; do
  [ -z "$f" ] && continue
  SKIP=0
  for p in "${EXPECTED[@]}"; do [[ "$f" == "$p"/* ]] && SKIP=1 && break; done
  [ "$SKIP" -eq 0 ] && UNEXPECTED+=("$f")
done <<< "$FOUND"
echo "Total SUID/SGID binaries found: $TOTAL"
if [ "${#UNEXPECTED[@]}" -gt 0 ]; then
  echo "ALERT: ${#UNEXPECTED[@]} unexpected SUID/SGID file(s) outside standard paths:"
  printf '  %s\n' "${UNEXPECTED[@]}"
  exit 1
fi
echo "All SUID/SGID files are in expected system paths"; exit 0
