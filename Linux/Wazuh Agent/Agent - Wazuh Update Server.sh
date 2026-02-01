#!/bin/bash

CONFIG_FILE="/var/ossec/etc/ossec.conf"

# Backup the config before modifying
cp "$CONFIG_FILE" "${CONFIG_FILE}.bak"

# Replace the address value inside the <address> tag
sed -i "s|<address>.*</address>|<address>${SERVER_ADDRESS}</address>|" "$CONFIG_FILE"

echo "OSSEC server address updated to ${SERVER_ADDRESS}"

# Restart Wazuh agent to apply changes
sudo systemctl restart wazuh-agent
echo "Wazuh agent restarted to apply new server address ${SERVER_ADDRESS}"