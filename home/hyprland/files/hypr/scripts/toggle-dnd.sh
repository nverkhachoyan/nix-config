#!/usr/bin/env bash
set -euo pipefail

if ! command -v makoctl >/dev/null 2>&1; then
  notify-send "makoctl not found"
  exit 1
fi

makoctl mode -t do-not-disturb

if makoctl mode 2>/dev/null | grep -q 'do-not-disturb'; then
  notify-send "󰂛 Notifications silenced"
else
  notify-send "󰂚 Notifications enabled"
fi

pkill -RTMIN+10 waybar >/dev/null 2>&1 || true
