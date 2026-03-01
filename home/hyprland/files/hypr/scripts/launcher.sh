#!/usr/bin/env bash
set -euo pipefail

exec wofi --conf "$HOME/.config/wofi/launcher.conf" --style "$HOME/.config/wofi/launcher.css"
