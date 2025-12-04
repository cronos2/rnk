#!/bin/bash
set -e

URL="https://antifilter.download/list/domains.lst"
OUTFILE="domains.lst"
TMPFILE="domains.lst.tmp"

echo "Downloading domains list…"

curl -fsSL "$URL" -o "$TMPFILE"

if [ ! -f "$OUTFILE" ]; then
    echo "domains.lst does not exist — creating new file."
    mv "$TMPFILE" "$OUTFILE"
    exit 0
fi

# Check if file has changed
if cmp -s "$TMPFILE" "$OUTFILE"; then
    echo "No changes in domains.lst"
    rm "$TMPFILE"
else
    echo "domains.lst updated."
    mv "$TMPFILE" "$OUTFILE"
fi
