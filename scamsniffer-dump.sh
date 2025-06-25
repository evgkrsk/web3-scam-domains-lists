#!/bin/sh
curl -sSL https://raw.githubusercontent.com/scamsniffer/scam-database/main/blacklist/domains.json |jq '.[]' |grep -Eio '[^"]+' |sort -u |tee scamsniffer.txt
