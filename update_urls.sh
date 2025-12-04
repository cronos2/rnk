#!/bin/bash
set -e

URL="https://antifilter.download/list/urls.lst"
OUTFILE="urls.lst"
TMPFILE="urls.lst.tmp"

echo "Downloading urls list…"

curl -fsSL "$URL" -o "$TMPFILE"

if [ ! -f "$OUTFILE" ]; then
    echo "urls.lst does not exist — creating new file."
    mv "$TMPFILE" "$OUTFILE"
    exit 0
fi

# Check if file has changed
if cmp -s "$TMPFILE" "$OUTFILE"; then
    echo "No changes in urls.lst"
    rm "$TMPFILE"
else
    echo "urls.lst updated."
    mv "$TMPFILE" "$OUTFILE"
fi
