#!/usr/bin/env bash
set -euo pipefail

PORT="${1:-8080}"

echo "Building site..."
./.tools/gleam run

# Check if the requested port is already in use
if nc -z 127.0.0.1 "$PORT" 2>/dev/null || lsof -Pi ":$PORT" -sTCP:LISTEN 2>/dev/null | grep -q ":$PORT"; then
  echo ""
  echo "Warning: port $PORT is already in use."
  echo "You can either:"
  echo "  1. Use a different port: ./serve.sh 8081"
  echo "  2. Kill the existing process and run ./serve.sh again"
  echo ""
  echo "Existing listeners on port $PORT:"
  lsof -Pi ":$PORT" -sTCP:LISTEN 2>/dev/null || true
  exit 1
fi

echo "Serving dist/ on http://127.0.0.1:$PORT"
python3 -m http.server "$PORT" --directory dist --bind 127.0.0.1
