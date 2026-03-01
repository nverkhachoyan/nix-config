#!/usr/bin/env bash
set -euo pipefail

if pgrep -f "gpu-screen-recorder|wf-recorder|obs" >/dev/null; then
  echo '{"text":"󰻂", "tooltip":"Recording active", "class":"active"}'
else
  echo '{"text":"", "tooltip":"No recording"}'
fi
