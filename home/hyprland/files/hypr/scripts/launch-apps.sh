#!/usr/bin/env bash
set -euo pipefail

PATH="$HOME/.nix-profile/bin:$PATH"

WALKER_BIN="$(command -v walker || true)"

if [ -z "${WALKER_BIN}" ] && [ -x "${HOME}/.nix-profile/bin/walker" ]; then
  WALKER_BIN="${HOME}/.nix-profile/bin/walker"
fi

if [ -z "${WALKER_BIN}" ]; then
  notify-send "Launcher error: walker binary not found"
  exit 1
fi

if command -v systemctl >/dev/null 2>&1; then
  systemctl --user start elephant.service >/dev/null 2>&1 || true
  systemctl --user start walker-gapplication.service >/dev/null 2>&1 || true
fi

if ! "${WALKER_BIN}" --width 644 --minheight 300 --maxheight 300 "$@"; then
  notify-send "Launcher error: walker failed to open"
  exit 1
fi
