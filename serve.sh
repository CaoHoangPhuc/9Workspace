#!/usr/bin/env bash
set -e

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
cd "$SCRIPT_DIR"

# Load environment variables if .env exists
if [ -f .env ]; then
  set -a
  source .env
  set +a
fi

PORT="${PORT:-8080}"
HOST="${HOST:-0.0.0.0}"

echo "Starting 9Workspace on http://localhost:${PORT} ..."
export PYTHONPATH="${SCRIPT_DIR}/backend"
exec "${SCRIPT_DIR}/.venv/bin/uvicorn" open_webui.main:app --port "$PORT" --host "$HOST" --forwarded-allow-ips "${FORWARDED_ALLOW_IPS:-*}"
