#!/usr/bin/env bash
# Check - NFS Mounts
# Lists NFS mounts and verifies they are accessible; exits 1 if any are stale.
nfs_mounts=$(mount -t nfs,nfs4 2>/dev/null | awk '{print $3}')
if [ -z "$nfs_mounts" ]; then echo "INFO: No NFS mounts found."; exit 0; fi
stale=()
while IFS= read -r mp; do
  if ! timeout 5 ls "$mp" &>/dev/null; then
    stale+=("$mp")
  else
    echo "OK: $mp"
  fi
done <<< "$nfs_mounts"
if [ "${#stale[@]}" -gt 0 ]; then
  echo "ALERT: Stale NFS mount(s) detected:"
  printf '  %s\n' "${stale[@]}"
  exit 1
fi
echo "OK: All NFS mounts are accessible."; exit 0
