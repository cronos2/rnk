#!/bin/bash

# === CONFIG ===
#!/bin/bash

API_URL="${API_URL}"
API_KEY="${API_KEY}"

OUT_FILE="custom-domains.csv"
TMP_FILE="${OUT_FILE}.tmp"

if [[ -z "$API_URL" || -z "$API_KEY" ]]; then
  echo "API_URL or API_KEY not set"
  exit 1
fi

echo "Downloading CSV from $API_URL..."

HTTP_CODE=$(curl -s -w "%{http_code}" \
  -H "X-API-KEY: $API_KEY" \
  "$API_URL" \
  -o "$TMP_FILE")
  
# === CHECK RESPONSE ===
if [[ "$HTTP_CODE" != "200" ]]; then
    echo "Error: Server returned HTTP $HTTP_CODE"
    rm -f "$TMP_FILE"
    exit 1
fi

# === SAVE FILE ATOMICALLY ===
mv "$TMP_FILE" "$OUT_FILE"
echo "Saved to $OUT_FILE"
