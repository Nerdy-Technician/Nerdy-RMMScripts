#!/usr/bin/env bash
# Maintain - Clear User Cache
# Clears ~/.cache directories for all non-system users; reports space freed.
before=$(df / | awk 'NR==2{print $3}')
for home in /home/*/; do
  [ -d "${home}.cache" ] && rm -rf "${home}.cache/"* 2>/dev/null && echo "Cleared: ${home}.cache"
done
after=$(df / | awk 'NR==2{print $3}')
freed=$(( (before - after) / 1024 ))
echo "Estimated space freed: ${freed} MB"
exit 0
