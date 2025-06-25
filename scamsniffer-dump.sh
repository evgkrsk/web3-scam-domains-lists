#!/bin/sh
curl -sSL https://raw.githubusercontent.com/scamsniffer/scam-database/main/blacklist/domains.json |jq '.[]' |grep -Eio '[^"]+' |grep -Eiv '^(walletconnect.org|storage.googleapis.com)$' |tee scamsniffer.txt
