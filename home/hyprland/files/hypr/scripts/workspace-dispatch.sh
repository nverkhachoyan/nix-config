#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  workspace-dispatch.sh goto <workspace>
  workspace-dispatch.sh move <workspace>
  workspace-dispatch.sh move-silent <workspace>
EOF
}

mode="${1:-}"
target="${2:-}"

if [ -z "${mode}" ] || [ -z "${target}" ]; then
  usage
  exit 1
fi

is_hyprsplit_loaded() {
  hyprctl plugin list 2>/dev/null | grep -Eiq '(^|[^[:alnum:]_])hyprsplit([^[:alnum:]_]|$)'
}

dispatch_workspace() {
  local dispatcher="$1"
  local value="$2"
  hyprctl dispatch "${dispatcher}" "${value}" >/dev/null 2>&1 || true
}

case "${mode}" in
  goto)
    if is_hyprsplit_loaded; then
      dispatch_workspace "split:workspace" "${target}"
    else
      dispatch_workspace "workspace" "${target}"
    fi
    ;;
  move)
    if is_hyprsplit_loaded; then
      dispatch_workspace "split:movetoworkspace" "${target}"
    else
      dispatch_workspace "movetoworkspace" "${target}"
    fi
    ;;
  move-silent)
    if is_hyprsplit_loaded; then
      dispatch_workspace "split:movetoworkspacesilent" "${target}"
    else
      dispatch_workspace "movetoworkspacesilent" "${target}"
    fi
    ;;
  *)
    usage
    exit 1
    ;;
esac
