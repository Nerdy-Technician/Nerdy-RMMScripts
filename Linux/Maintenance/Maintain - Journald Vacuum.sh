#!/usr/bin/env bash
# Maintain - Journald Vacuum
# Trims journal logs to MAX_SIZE (default 500M) and MAX_TIME (default 30days).
MAX_SIZE="${MAX_SIZE:-500M}"
MAX_TIME="${MAX_TIME:-30days}"
echo "Vacuuming journal: size cap=${MAX_SIZE}, time cap=${MAX_TIME}"
journalctl --vacuum-size="$MAX_SIZE" --vacuum-time="$MAX_TIME" 2>&1
exit 0
