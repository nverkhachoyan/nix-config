#!/usr/bin/env bash
set -euo pipefail

if ! command -v hyprctl >/dev/null 2>&1 || ! command -v hyprsunset >/dev/null 2>&1; then
  echo '{"text":""}'
  exit 0
fi

TEMP="$(hyprctl hyprsunset temperature 2>/dev/null | grep -oE '[0-9]+' | head -n 1 || true)"

if [ -n "$TEMP" ] && [ "$TEMP" -lt 5000 ]; then
  echo '{"text":"", "tooltip":"Night light enabled", "class":"active"}'
else
  echo '{"text":"", "tooltip":"Night light disabled"}'
fi
