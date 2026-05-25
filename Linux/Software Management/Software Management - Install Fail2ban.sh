#!/usr/bin/env bash
# Software Management - Install Fail2ban
# Installs and enables fail2ban for SSH brute-force protection.
if systemctl is-active --quiet fail2ban; then
  echo "INFO: fail2ban is already running."; exit 0
fi
apt-get update -qq && apt-get install -y fail2ban
systemctl enable fail2ban
systemctl start fail2ban
systemctl is-active fail2ban && echo "OK: fail2ban installed and running." && exit 0
echo "ERROR: fail2ban failed to start."; exit 1
