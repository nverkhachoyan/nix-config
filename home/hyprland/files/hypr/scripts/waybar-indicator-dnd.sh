#!/usr/bin/env bash
set -euo pipefail

if ! command -v makoctl >/dev/null 2>&1; then
  echo '{"text":"", "tooltip":"makoctl unavailable"}'
  exit 0
fi

if makoctl mode 2>/dev/null | grep -q 'do-not-disturb'; then
  echo '{"text":"󰂛", "tooltip":"Notifications silenced", "class":"active"}'
else
  echo '{"text":"", "tooltip":"Notifications enabled"}'
fi
