#!/bin/sh
curl -sSL https://raw.githubusercontent.com/scamsniffer/scam-database/main/blacklist/domains.json |jq -r '.[]' |sort -u |tee scamsniffer.txt
