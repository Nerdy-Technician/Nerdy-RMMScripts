#!/usr/bin/env bash
# Collect - CPU Info
# Reports CPU model, count, and architecture.
echo "Model: $(grep -m1 'model name' /proc/cpuinfo | cut -d: -f2 | xargs)"
echo "Physical CPUs: $(grep -c 'processor' /proc/cpuinfo)"
echo "Architecture: $(uname -m)"
exit 0
