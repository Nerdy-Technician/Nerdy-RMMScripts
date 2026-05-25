#!/usr/bin/env bash
# Collect - Running Services
# Lists all currently active systemd services.
systemctl list-units --type=service --state=active --no-pager --no-legend | awk '{print $1, $3, $4}'
exit 0
