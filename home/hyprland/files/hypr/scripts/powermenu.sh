#!/usr/bin/env bash
set -euo pipefail

if command -v wlogout >/dev/null 2>&1; then
  exec wlogout --layout "$HOME/.config/wlogout/layout" --css "$HOME/.config/wlogout/style.css"
fi

choice="$(
  printf '%s\n' "Lock" "Suspend" "Logout" "Reboot" "Shutdown" \
    | wofi --dmenu --prompt "Power" --style "$HOME/.config/wofi/powermenu.css"
)"

case "${choice:-}" in
  Lock)
    exec hyprlock
    ;;
  Suspend)
    loginctl suspend
    ;;
  Logout)
    hyprctl dispatch exit
    ;;
  Reboot)
    systemctl reboot
    ;;
  Shutdown)
    systemctl poweroff
    ;;
  *)
    exit 0
    ;;
esac
