#!/bin/bash
set -e

URL="https://antifilter.download/list/ip.lst"
OUTFILE="ip.lst"
TMPFILE="ip.lst.tmp"

echo "Downloading domains list…"

curl -fsSL "$URL" -o "$TMPFILE"

if [ ! -f "$OUTFILE" ]; then
    echo "ip.lst does not exist — creating new file."
    mv "$TMPFILE" "$OUTFILE"
    exit 0
fi

# Check if file has changed
if cmp -s "$TMPFILE" "$OUTFILE"; then
    echo "No changes in ip.lst"
    rm "$TMPFILE"
else
    echo "ip.lst updated."
    mv "$TMPFILE" "$OUTFILE"
fi
