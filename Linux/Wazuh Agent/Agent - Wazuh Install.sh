#!/bin/sh

OSSEC_CONF="/var/ossec/etc/ossec.conf"
AGENT_BIN="/var/ossec/bin/wazuh-agentd"

### Default group ###
WAZUH_GROUP="${Wazuhgroup:-default}"

### Validate wazuh_url ###
if [ -z "$wazuh_url" ]; then
    echo "ERROR: wazuh_url is not set"
    exit 1
fi

### Check if agent already installed ###
if [ -x "$AGENT_BIN" ]; then
    echo "Wazuh agent already installed"

    ### Check group match ###
    if [ -f "$OSSEC_CONF" ]; then
        CURRENT_GROUP=$(grep -oP '(?<=<groups>).*?(?=</groups>)' "$OSSEC_CONF" | head -n1)


        if [ "$CURRENT_GROUP" != "$WAZUH_GROUP" ]; then
            echo "Group mismatch"
            echo "Expected: $WAZUH_GROUP"
            echo "Found: $CURRENT_GROUP"
            exit 1
        fi
    fi

    exit 0
fi

### Download agent ###
DEB="wazuh-agent_4.14.1-1_amd64.deb"

if ! command -v wget >/dev/null 2>&1; then
    apt-get update -y
    apt-get install -y wget
fi

wget -q https://packages.wazuh.com/4.x/apt/pool/main/w/wazuh-agent/$DEB

### Install ###
WAZUH_MANAGER="$wazuh_url" \
WAZUH_AGENT_GROUP="$WAZUH_GROUP" \
dpkg -i ./$DEB

### Enable & start ###
systemctl daemon-reload
systemctl enable wazuh-agent
systemctl start wazuh-agent

### Verify group after install ###
if [ -f "$OSSEC_CONF" ]; then
    CURRENT_GROUP=$(grep -oP '(?<=<group>).*?(?=</group>)' "$OSSEC_CONF" | head -n1)

    if [ "$CURRENT_GROUP" != "$WAZUH_GROUP" ]; then
        echo "Post-install group mismatch"
        echo "Expected: $WAZUH_GROUP"
        echo "Found: $CURRENT_GROUP"
        exit 2
    fi
fi

echo "Wazuh agent installed and configured correctly"
exit 0
