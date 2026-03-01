#!/usr/bin/env bash
set -euo pipefail

if ! command -v hypridle >/dev/null 2>&1; then
  echo '{"text":"", "tooltip":"hypridle not installed"}'
  exit 0
fi

if pgrep -x hypridle >/dev/null 2>&1; then
  echo '{"text":"", "tooltip":"Idle lock enabled"}'
else
  echo '{"text":"󱫖", "tooltip":"Idle lock disabled", "class":"active"}'
fi
