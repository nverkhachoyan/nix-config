#!/usr/bin/env bash
set -euo pipefail

ON_TEMP=4000
OFF_TEMP=6500

if ! command -v hyprsunset >/dev/null 2>&1; then
  notify-send "hyprsunset not installed"
  exit 1
fi
if ! command -v hyprctl >/dev/null 2>&1; then
  notify-send "hyprctl not found"
  exit 1
fi

if ! pgrep -x hyprsunset >/dev/null 2>&1; then
  nohup hyprsunset >/dev/null 2>&1 &
  sleep 0.8
fi

CURRENT_TEMP="$(hyprctl hyprsunset temperature 2>/dev/null | grep -oE '[0-9]+' | head -n 1 || true)"

if [ "$CURRENT_TEMP" = "$OFF_TEMP" ] || [ -z "$CURRENT_TEMP" ]; then
  hyprctl hyprsunset temperature "$ON_TEMP" >/dev/null 2>&1
  notify-send " Night light on"
else
  hyprctl hyprsunset temperature "$OFF_TEMP" >/dev/null 2>&1
  notify-send " Night light off"
fi

pkill -RTMIN+11 waybar >/dev/null 2>&1 || true
