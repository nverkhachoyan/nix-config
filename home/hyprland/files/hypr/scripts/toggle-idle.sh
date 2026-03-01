#!/usr/bin/env bash
set -euo pipefail

if ! command -v hypridle >/dev/null 2>&1; then
  notify-send "Idle toggle unavailable: hypridle not installed"
  exit 1
fi

if pgrep -x hypridle >/dev/null 2>&1; then
  pkill -x hypridle
  notify-send "󱫖 Idle lock disabled"
else
  nohup hypridle >/dev/null 2>&1 &
  notify-send "󱫖 Idle lock enabled"
fi

pkill -RTMIN+9 waybar >/dev/null 2>&1 || true
