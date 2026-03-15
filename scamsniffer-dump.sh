#!/bin/sh
set -e

TMP_FILE=$(mktemp)

echo "Downloading domains from scamsniffer..."
curl -sSL https://raw.githubusercontent.com/scamsniffer/scam-database/main/blacklist/domains.json | jq -r '.[]' | sort -u > "$TMP_FILE"

echo "Validating domain format..."
INVALID=$(grep -cvE '^[a-zA-Z0-9]([a-zA-Z0-9\-]*[a-zA-Z0-9])?(\.[a-zA-Z0-9]([a-zA-Z0-9\-]*[a-zA-Z0-9])?)*\.[a-zA-Z]{2,}$' "$TMP_FILE" 2>/dev/null || echo 0)
if [ "$INVALID" -gt 0 ]; then
    echo "Warning: $INVALID invalid entries found, filtering..."
    grep -E '^[a-zA-Z0-9]([a-zA-Z0-9\-]*[a-zA-Z0-9])?(\.[a-zA-Z0-9]([a-zA-Z0-9\-]*[a-zA-Z0-9])?)*\.[a-zA-Z]{2,}$' "$TMP_FILE" > scamsniffer.txt
else
    mv "$TMP_FILE" scamsniffer.txt
    echo "All entries are valid domains."
fi

rm -f "$TMP_FILE" 2>/dev/null || true
echo "Done. $(wc -l < scamsniffer.txt) domains in list."
