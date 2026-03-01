#!/usr/bin/env bash
set -euo pipefail

PATH="${HOME}/.nix-profile/bin:${PATH}"

CONTEXT="${1:-main}"
WOFI_STYLE="${HOME}/.config/wofi/quick-settings.css"
WOFI_CONF="${HOME}/.config/wofi/quick-settings.conf"

spawn_bg() {
  if command -v uwsm-app >/dev/null 2>&1; then
    setsid uwsm-app -- "$@" >/dev/null 2>&1 &
  else
    setsid "$@" >/dev/null 2>&1 &
  fi
}

open_network_settings() {
  if command -v nm-connection-editor >/dev/null 2>&1; then
    spawn_bg nm-connection-editor
  elif command -v gnome-control-center >/dev/null 2>&1; then
    spawn_bg gnome-control-center network
  else
    notify-send "Network settings app not found"
  fi
}

open_audio_settings() {
  if command -v pavucontrol >/dev/null 2>&1; then
    spawn_bg pavucontrol
  else
    notify-send "Audio mixer not found (pavucontrol)"
  fi
}

open_display_settings() {
  if command -v gnome-control-center >/dev/null 2>&1; then
    spawn_bg gnome-control-center display
  else
    notify-send "Display settings app not found"
  fi
}

open_bluetooth_settings() {
  if command -v blueman-manager >/dev/null 2>&1; then
    spawn_bg blueman-manager
  elif command -v gnome-control-center >/dev/null 2>&1; then
    spawn_bg gnome-control-center bluetooth
  else
    notify-send "Bluetooth settings app not found"
  fi
}

open_power_settings() {
  if command -v gnome-control-center >/dev/null 2>&1; then
    spawn_bg gnome-control-center power
  else
    notify-send "Power settings app not found"
  fi
}

open_system_settings() {
  if command -v gnome-control-center >/dev/null 2>&1; then
    spawn_bg gnome-control-center
  else
    notify-send "System settings app not found"
  fi
}

toggle_wifi() {
  if ! command -v nmcli >/dev/null 2>&1; then
    notify-send "nmcli not found"
    return
  fi

  if nmcli radio wifi | grep -qi "^enabled$"; then
    nmcli radio wifi off
    notify-send "Wi-Fi disabled"
  else
    nmcli radio wifi on
    notify-send "Wi-Fi enabled"
  fi
}

toggle_mute() {
  if command -v swayosd-client >/dev/null 2>&1; then
    swayosd-client --output-volume mute-toggle
  elif command -v wpctl >/dev/null 2>&1; then
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
  else
    notify-send "Audio control command not found"
  fi
}

context_prompt() {
  case "${CONTEXT}" in
    network) echo "Network" ;;
    audio) echo "Audio" ;;
    display) echo "Display" ;;
    power) echo "Power" ;;
    *) echo "Quick Settings" ;;
  esac
}

show_menu() {
  local prompt selection
  local -a options

  prompt="$(context_prompt)"
  options=(
    "󰖩  Network"
    "󰤨  Wi-Fi"
    "󰖀  Audio"
    "󰖁  Mute"
    "󰍹  Display"
    "󰂯  Bluetooth"
    "󱐋  Power"
    "  Settings"
    "󱫖  Idle lock"
    "󰂛  DND"
    "  Night light"
    "󰸉  Wallpaper"
    "󰐥  Power menu"
  )

  selection="$(
    printf '%s\n' "${options[@]}" \
      | wofi --dmenu --prompt "${prompt}" --style "${WOFI_STYLE}" --conf "${WOFI_CONF}"
  )"

  [ -n "${selection}" ] || exit 0

  case "${selection}" in
    *"Network") open_network_settings ;;
    *"Wi-Fi") toggle_wifi ;;
    *"Audio") open_audio_settings ;;
    *"Mute") toggle_mute ;;
    *"Display") open_display_settings ;;
    *"Bluetooth") open_bluetooth_settings ;;
    *"Power") open_power_settings ;;
    *"Settings") open_system_settings ;;
    *"Idle lock") "${HOME}/.config/hypr/scripts/toggle-idle.sh" ;;
    *"DND") "${HOME}/.config/hypr/scripts/toggle-dnd.sh" ;;
    *"Night light") "${HOME}/.config/hypr/scripts/toggle-nightlight.sh" ;;
    *"Wallpaper") "${HOME}/.config/hypr/scripts/wallpaper-rotate.sh" ;;
    *"Power menu") "${HOME}/.config/hypr/scripts/powermenu.sh" ;;
    *) exit 0 ;;
  esac
}

if ! command -v wofi >/dev/null 2>&1; then
  notify-send "Quick settings requires wofi"
  exit 1
fi

show_menu
