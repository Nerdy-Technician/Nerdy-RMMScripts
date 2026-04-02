#!/usr/bin/env bash
# Check - SSL Cert Expiry
# Scans /etc/ssl/certs for PEM certs expiring within WARN_DAYS (default 30). Exits 1 if expired, 2 if expiring soon.
WARN_DAYS="${WARN_DAYS:-30}"
ALERT=0; WARN=0; NOW=$(date +%s)
while IFS= read -r -d '' cert; do
  exp=$(openssl x509 -noout -enddate -in "$cert" 2>/dev/null | cut -d= -f2) || continue
  exp_ts=$(date -d "$exp" +%s 2>/dev/null) || continue
  days_left=$(( (exp_ts - NOW) / 86400 ))
  if [ "$days_left" -lt 0 ]; then
    echo "EXPIRED: $(basename "$cert") (${days_left}d ago)"; ALERT=1
  elif [ "$days_left" -lt "$WARN_DAYS" ]; then
    echo "EXPIRING: $(basename "$cert") (${days_left}d remaining)"; WARN=1
  fi
done < <(find /etc/ssl/certs -name "*.pem" -print0 2>/dev/null)
[ "$ALERT" -eq 1 ] && exit 1
[ "$WARN" -eq 1 ] && exit 2
echo "All SSL certs valid (>${WARN_DAYS}d remaining)"; exit 0
