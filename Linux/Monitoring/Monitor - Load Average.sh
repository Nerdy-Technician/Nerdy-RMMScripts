#!/usr/bin/env bash
# Monitor - Load Average
# Reports 1/5/15 min load averages relative to CPU count; exits 1 if 1min load > nCPU.
ncpu=$(nproc)
read -r load1 load5 load15 _ < /proc/loadavg
echo "Load average: $load1 $load5 $load15 (CPUs: $ncpu)"
if (( $(echo "$load1 > $ncpu" | bc -l) )); then
  echo "ALERT: 1-minute load ($load1) exceeds CPU count ($ncpu)."; exit 1
fi
if (( $(echo "$load5 > $ncpu" | bc -l) )); then
  echo "WARNING: 5-minute load ($load5) exceeds CPU count ($ncpu)."; exit 2
fi
echo "OK: Load within normal range."; exit 0
