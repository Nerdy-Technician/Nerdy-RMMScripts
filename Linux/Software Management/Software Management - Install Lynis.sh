#!/usr/bin/env bash
# Software Management - Install Lynis
# Installs Lynis security auditing tool from the CISOfy repository.
if command -v lynis &>/dev/null; then
  echo "INFO: Lynis already installed: $(lynis show version)"; exit 0
fi
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C80E383C3DE9F082E01391A0366C67DE91CA5D5F 2>/dev/null || true
echo "deb https://packages.cisofy.com/community/lynis/deb/ stable main" > /etc/apt/sources.list.d/cisofy-lynis.list
apt-get update -qq && apt-get install -y lynis
lynis show version && echo "OK: Lynis installed." && exit 0
echo "ERROR: Lynis installation failed."; exit 1
