#!/usr/bin/env bash
set -euo pipefail

WALLPAPER_DIR="${HOME}/Docs/Pictures/Wallpapers"
STATE_DIR="${XDG_STATE_HOME:-${HOME}/.local/state}/hypr-theme"
CURRENT_WALLPAPER_FILE="${STATE_DIR}/current_wallpaper"

WAYBAR_COLORS_FILE="${HOME}/.config/waybar/colors.css"
WALKER_COLORS_FILE="${HOME}/.config/walker/theme-colors.css"
WLOGOUT_COLORS_FILE="${HOME}/.config/wlogout/theme-colors.css"
SWAYOSD_COLORS_FILE="${HOME}/.config/swayosd/theme-colors.css"
HYPRLOCK_COLORS_FILE="${HOME}/.config/hypr/hyprlock-colors.conf"

mkdir -p \
  "${STATE_DIR}" \
  "$(dirname "${WAYBAR_COLORS_FILE}")" \
  "$(dirname "${WALKER_COLORS_FILE}")" \
  "$(dirname "${WLOGOUT_COLORS_FILE}")" \
  "$(dirname "${SWAYOSD_COLORS_FILE}")" \
  "$(dirname "${HYPRLOCK_COLORS_FILE}")"

usage() {
  cat <<'EOF'
Usage:
  theme-wallpaper.sh [--random]
  theme-wallpaper.sh --set /absolute/path/to/wallpaper
  theme-wallpaper.sh --reapply
EOF
}

require_cmd() {
  local cmd="$1"
  if ! command -v "${cmd}" >/dev/null 2>&1; then
    echo "Missing required command: ${cmd}" >&2
    exit 1
  fi
}

ensure_swww_ready() {
  if swww query >/dev/null 2>&1; then
    return
  fi

  systemctl --user start swww-daemon.service >/dev/null 2>&1 || true
  sleep 0.5

  if swww query >/dev/null 2>&1; then
    return
  fi

  nohup swww-daemon >/dev/null 2>&1 &
  sleep 0.7

  if ! swww query >/dev/null 2>&1; then
    echo "Failed to start swww-daemon. Install and verify swww first." >&2
    exit 1
  fi
}

collect_wallpapers() {
  if [ ! -d "${WALLPAPER_DIR}" ]; then
    echo "Wallpaper directory does not exist: ${WALLPAPER_DIR}" >&2
    return 1
  fi

  find "${WALLPAPER_DIR}" -maxdepth 1 -type f \
    \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) \
    | sort
}

pick_random_wallpaper() {
  local current=""
  local selected=""
  if ! mapfile -t wallpapers < <(collect_wallpapers); then
    exit 1
  fi

  if [ "${#wallpapers[@]}" -eq 0 ]; then
    echo "No wallpapers found in ${WALLPAPER_DIR}" >&2
    exit 1
  fi

  if [ -f "${CURRENT_WALLPAPER_FILE}" ]; then
    current="$(cat "${CURRENT_WALLPAPER_FILE}")"
  fi

  selected="$(printf '%s\n' "${wallpapers[@]}" | shuf -n 1)"

  if [ "${#wallpapers[@]}" -gt 1 ] && [ "${selected}" = "${current}" ]; then
    selected="$(printf '%s\n' "${wallpapers[@]}" | grep -Fvx "${current}" | shuf -n 1)"
  fi

  printf '%s\n' "${selected}"
}

extract_dominant_hex() {
  local image="$1"
  local hex

  hex="$(
    magick "${image}" \
      -resize 240x240^ \
      -gravity center \
      -extent 240x240 \
      -colors 8 \
      -format %c histogram:info:- \
      | sort -nr \
      | head -n 1 \
      | sed -E 's/.*#([0-9A-Fa-f]{6}).*/\1/' \
      | tr 'A-F' 'a-f'
  )"

  if [[ ! "${hex}" =~ ^[0-9a-f]{6}$ ]]; then
    hex="7dd3fc"
  fi

  printf '%s\n' "${hex}"
}

derive_colors() {
  local base_hex="$1"

  python3 - "${base_hex}" <<'PY'
import sys

base = sys.argv[1].lower().strip()
r, g, b = [int(base[i:i+2], 16) for i in (0, 2, 4)]

def mix(a, b, t):
    return round(a + (b - a) * t)

light = (mix(r, 255, 0.30), mix(g, 255, 0.30), mix(b, 255, 0.30))
dark = (mix(r, 0, 0.35), mix(g, 0, 0.35), mix(b, 0, 0.35))
luma = (0.2126 * r + 0.7152 * g + 0.0722 * b) / 255.0
accent_text = "0f1318" if luma > 0.62 else "f5f9ff"

print(f"accent_raw={base}")
print(f"accent_hex=#{base}")
print(f"accent_light={light[0]:02x}{light[1]:02x}{light[2]:02x}")
print(f"accent_dark={dark[0]:02x}{dark[1]:02x}{dark[2]:02x}")
print(f"accent_soft=rgba({r},{g},{b},0.24)")
print(f"accent_strong=rgba({r},{g},{b},0.36)")
print(f"accent_border=rgba({r},{g},{b},0.44)")
print(f"accent_glow=rgba({r},{g},{b},0.24)")
print("glass_bg=rgba(11,15,21,0.72)")
print("glass_chip=rgba(255,255,255,0.08)")
print("module_bg=rgba(255,255,255,0.07)")
print("module_bg_hover=rgba(255,255,255,0.12)")
print("surface_bg=rgba(13,17,24,0.94)")
print("overlay_bg=rgba(8,10,14,0.62)")
print("fg=#eaf0f8")
print("muted=#b7c4d6")
print(f"accent_text=#{accent_text}")
print("critical=#f87171")
print("warning=#fbbf24")
print(f"r={r}")
print(f"g={g}")
print(f"b={b}")
PY
}

write_waybar_colors() {
  local -n palette="$1"
  cat > "${WAYBAR_COLORS_FILE}" <<EOF
@define-color accent ${palette[accent_hex]};
@define-color accent_light #${palette[accent_light]};
@define-color accent_dark #${palette[accent_dark]};
@define-color accent_soft ${palette[accent_soft]};
@define-color accent_strong ${palette[accent_strong]};
@define-color accent_border ${palette[accent_border]};
@define-color accent_glow ${palette[accent_glow]};
@define-color accent_text ${palette[accent_text]};
@define-color glass_bg ${palette[glass_bg]};
@define-color glass_chip ${palette[glass_chip]};
@define-color module_bg ${palette[module_bg]};
@define-color module_bg_hover ${palette[module_bg_hover]};
@define-color surface_bg ${palette[surface_bg]};
@define-color overlay_bg ${palette[overlay_bg]};
@define-color fg ${palette[fg]};
@define-color muted ${palette[muted]};
@define-color critical ${palette[critical]};
@define-color warning ${palette[warning]};
EOF
}

write_walker_colors() {
  local -n palette="$1"
  cat > "${WALKER_COLORS_FILE}" <<EOF
@define-color foreground ${palette[fg]};
@define-color muted ${palette[muted]};
@define-color background ${palette[surface_bg]};
@define-color chip ${palette[module_bg]};
@define-color accent ${palette[accent_hex]};
@define-color accent_soft ${palette[accent_soft]};
@define-color accent_text ${palette[accent_text]};
@define-color border ${palette[accent_border]};
EOF
}

write_wlogout_colors() {
  local -n palette="$1"
  cat > "${WLOGOUT_COLORS_FILE}" <<EOF
@define-color foreground ${palette[fg]};
@define-color background ${palette[overlay_bg]};
@define-color card ${palette[surface_bg]};
@define-color card_hover ${palette[module_bg_hover]};
@define-color accent ${palette[accent_hex]};
@define-color accent_soft ${palette[accent_soft]};
@define-color border ${palette[accent_border]};
@define-color danger ${palette[critical]};
EOF
}

write_swayosd_colors() {
  local -n palette="$1"
  cat > "${SWAYOSD_COLORS_FILE}" <<EOF
@define-color background-color ${palette[surface_bg]};
@define-color border-color ${palette[accent_hex]};
@define-color label ${palette[fg]};
@define-color image ${palette[fg]};
@define-color progress ${palette[accent_hex]};
EOF
}

write_hyprlock_colors() {
  local -n palette="$1"
  cat > "${HYPRLOCK_COLORS_FILE}" <<EOF
\$color = rgba(13,17,24,0.92)
\$inner_color = rgba(23,30,42,0.86)
\$outer_color = rgba(${palette[r]},${palette[g]},${palette[b]},0.95)
\$font_color = rgba(234,240,248,1.0)
\$check_color = rgba(${palette[r]},${palette[g]},${palette[b]},1.0)
EOF
}

reload_waybar() {
  if systemctl --user is-active --quiet waybar.service; then
    systemctl --user reload waybar.service >/dev/null 2>&1 || pkill -SIGUSR2 waybar >/dev/null 2>&1 || true
  fi
}

refresh_waybar_indicators() {
  pkill -RTMIN+8 waybar >/dev/null 2>&1 || true
  pkill -RTMIN+9 waybar >/dev/null 2>&1 || true
  pkill -RTMIN+10 waybar >/dev/null 2>&1 || true
  pkill -RTMIN+11 waybar >/dev/null 2>&1 || true
}

restart_swayosd_if_active() {
  if ! command -v swayosd-server >/dev/null 2>&1; then
    return
  fi

  if pgrep -x swayosd-server >/dev/null 2>&1; then
    pkill -x swayosd-server >/dev/null 2>&1 || true
    nohup swayosd-server >/dev/null 2>&1 &
  fi
}

apply_hypr_borders() {
  local accent_raw="$1"
  local accent_light="$2"

  hyprctl keyword general:col.active_border "rgba(${accent_raw}ee) rgba(${accent_light}ee) 45deg" >/dev/null 2>&1 || true
  hyprctl keyword general:col.inactive_border "rgba(595959aa)" >/dev/null 2>&1 || true
}

main() {
  local mode="random"
  local target=""

  case "${1:---random}" in
    --random)
      mode="random"
      ;;
    --set)
      mode="set"
      target="${2:-}"
      if [ -z "${target}" ]; then
        usage
        exit 1
      fi
      ;;
    --reapply)
      mode="reapply"
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      usage
      exit 1
      ;;
  esac

  require_cmd swww
  require_cmd swww-daemon
  require_cmd magick
  require_cmd python3

  case "${mode}" in
    set)
      if command -v realpath >/dev/null 2>&1; then
        target="$(realpath "${target}")"
      elif command -v readlink >/dev/null 2>&1; then
        target="$(readlink -f "${target}")"
      fi
      if [ ! -f "${target}" ] || [ ! -r "${target}" ]; then
        echo "Wallpaper is not readable: ${target}" >&2
        exit 1
      fi
      ;;
    reapply)
      if [ -f "${CURRENT_WALLPAPER_FILE}" ] && [ -r "${CURRENT_WALLPAPER_FILE}" ]; then
        target="$(cat "${CURRENT_WALLPAPER_FILE}")"
      fi
      if [ -z "${target}" ] || [ ! -f "${target}" ]; then
        target="$(pick_random_wallpaper)"
      fi
      ;;
    random)
      target="$(pick_random_wallpaper)"
      ;;
  esac

  ensure_swww_ready

  swww img "${target}" \
    --transition-type grow \
    --transition-duration 1.1 \
    --transition-fps 60 >/dev/null

  printf '%s\n' "${target}" > "${CURRENT_WALLPAPER_FILE}"

  local dominant_hex
  dominant_hex="$(extract_dominant_hex "${target}")"

  local derived
  derived="$(derive_colors "${dominant_hex}")"

  declare -A colors=()
  while IFS='=' read -r key value; do
    [ -n "${key}" ] && colors["${key}"]="${value}"
  done <<< "${derived}"

  write_waybar_colors colors
  write_walker_colors colors
  write_wlogout_colors colors
  write_swayosd_colors colors
  write_hyprlock_colors colors

  apply_hypr_borders "${colors[accent_raw]}" "${colors[accent_light]}"
  reload_waybar
  refresh_waybar_indicators
  restart_swayosd_if_active
}

main "$@"
