#!/usr/bin/env bash
set -euo pipefail

WORKFLOW_ENV_FILE="${HOME}/.config/hypr/workspace-workflow.env"
THEME_SCRIPT="${HOME}/.config/hypr/scripts/theme-wallpaper.sh"

if [ -f "${WORKFLOW_ENV_FILE}" ]; then
  # shellcheck disable=SC1090
  . "${WORKFLOW_ENV_FILE}"
fi

if [ -z "${HYPRLAND_INSTANCE_SIGNATURE:-}" ]; then
  echo "HYPRLAND_INSTANCE_SIGNATURE is not set" >&2
  exit 1
fi

if ! command -v socat >/dev/null 2>&1; then
  echo "Missing required command: socat" >&2
  exit 1
fi

if ! command -v hyprctl >/dev/null 2>&1; then
  echo "Missing required command: hyprctl" >&2
  exit 1
fi

RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
SOCKET_PATH="${RUNTIME_DIR}/hypr/${HYPRLAND_INSTANCE_SIGNATURE}/.socket2.sock"

if [ ! -S "${SOCKET_PATH}" ]; then
  echo "Hyprland socket2 not found: ${SOCKET_PATH}" >&2
  exit 1
fi

parse_monitor_name() {
  local payload="$1"
  local first=""
  local second=""

  IFS=',' read -r first second _ <<< "${payload}"
  first="${first%% *}"
  second="${second%% *}"

  if [[ "${first}" =~ ^[0-9]+$ ]] && [ -n "${second}" ]; then
    printf '%s\n' "${second}"
  else
    printf '%s\n' "${first}"
  fi
}

handle_monitor_added() {
  local payload="$1"
  local monitor=""

  monitor="$(parse_monitor_name "${payload}")"
  if [ -z "${monitor}" ]; then
    return
  fi

  sleep 0.8
  "${THEME_SCRIPT}" --random-output "${monitor}" >/dev/null 2>&1 || true
}

handle_monitor_removed() {
  hyprctl dispatch split:grabroguewindows >/dev/null 2>&1 || true
}

while true; do
  while IFS= read -r event_line; do
    event="${event_line%%>>*}"
    payload="${event_line#*>>}"

    if [ "${payload}" = "${event_line}" ]; then
      payload=""
    fi

    case "${event}" in
      monitoradded|monitoraddedv2)
        handle_monitor_added "${payload}"
        ;;
      monitorremoved|monitorremovedv2)
        handle_monitor_removed
        ;;
    esac
  done < <(socat -U - "UNIX-CONNECT:${SOCKET_PATH}" 2>/dev/null || true)

  sleep 1
done
