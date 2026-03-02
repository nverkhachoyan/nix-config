#!/usr/bin/env bash
set -euo pipefail

WALLPAPER_DIR="${HOME}/Docs/Pictures/Wallpapers"
STATE_DIR="${XDG_STATE_HOME:-${HOME}/.local/state}/hypr-theme"
WORKFLOW_ENV_FILE="${HOME}/.config/hypr/workspace-workflow.env"

if [ -f "${WORKFLOW_ENV_FILE}" ]; then
  # shellcheck disable=SC1090
  . "${WORKFLOW_ENV_FILE}"
fi

LAPTOP_OUTPUT="${LAPTOP_OUTPUT:-eDP-1}"

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
  cat <<'USAGE'
Usage:
  theme-wallpaper.sh [--random]
  theme-wallpaper.sh --set /absolute/path/to/wallpaper
  theme-wallpaper.sh --reapply
  theme-wallpaper.sh --random-output <output>
USAGE
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

connected_outputs() {
  hyprctl monitors -j | jq -r '.[] | select((.disabled // false) | not) | .name'
}

wallpaper_state_file_for_output() {
  local output="$1"
  local safe_output="${output//[^[:alnum:]_.-]/_}"
  printf '%s/current_wallpaper_%s\n' "${STATE_DIR}" "${safe_output}"
}

read_current_wallpaper() {
  local output="$1"
  local state_file=""

  state_file="$(wallpaper_state_file_for_output "${output}")"
  if [ -r "${state_file}" ]; then
    cat "${state_file}"
  fi
}

write_current_wallpaper() {
  local output="$1"
  local wallpaper="$2"
  local state_file=""

  state_file="$(wallpaper_state_file_for_output "${output}")"
  printf '%s\n' "${wallpaper}" > "${state_file}"
}

read_displayed_wallpaper() {
  local output="$1"

  swww query 2>/dev/null | awk -v output="${output}" '
    $0 ~ ": " output ":" {
      pos = index($0, "image: ");
      if (pos > 0) {
        print substr($0, pos + 7);
        exit;
      }
    }
  '
}

pick_random_wallpaper() {
  local current="${1:-}"
  local selected=""

  if ! mapfile -t wallpapers < <(collect_wallpapers); then
    exit 1
  fi

  if [ "${#wallpapers[@]}" -eq 0 ]; then
    echo "No wallpapers found in ${WALLPAPER_DIR}" >&2
    exit 1
  fi

  selected="$(printf '%s\n' "${wallpapers[@]}" | shuf -n 1)"

  if [ "${#wallpapers[@]}" -gt 1 ] && [ -n "${current}" ] && [ "${selected}" = "${current}" ]; then
    selected="$(printf '%s\n' "${wallpapers[@]}" | grep -Fvx "${current}" | shuf -n 1)"
  fi

  printf '%s\n' "${selected}"
}

extract_dominant_hex() {
  local image="$1"
  local hex

  hex="$({
    magick "${image}" \
      -resize 240x240^ \
      -gravity center \
      -extent 240x240 \
      -colors 8 \
      -format %c histogram:info:-
  } | sort -nr | head -n 1 | sed -E 's/.*#([0-9A-Fa-f]{6}).*/\1/' | tr 'A-F' 'a-f')"

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
  cat > "${WAYBAR_COLORS_FILE}" <<PALETTE
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
PALETTE
}

write_walker_colors() {
  local -n palette="$1"
  cat > "${WALKER_COLORS_FILE}" <<PALETTE
@define-color foreground ${palette[fg]};
@define-color muted ${palette[muted]};
@define-color background ${palette[surface_bg]};
@define-color chip ${palette[module_bg]};
@define-color accent ${palette[accent_hex]};
@define-color accent_soft ${palette[accent_soft]};
@define-color accent_text ${palette[accent_text]};
@define-color border ${palette[accent_border]};
PALETTE
}

write_wlogout_colors() {
  local -n palette="$1"
  cat > "${WLOGOUT_COLORS_FILE}" <<PALETTE
@define-color foreground ${palette[fg]};
@define-color background ${palette[overlay_bg]};
@define-color card ${palette[surface_bg]};
@define-color card_hover ${palette[module_bg_hover]};
@define-color accent ${palette[accent_hex]};
@define-color accent_soft ${palette[accent_soft]};
@define-color border ${palette[accent_border]};
@define-color danger ${palette[critical]};
PALETTE
}

write_swayosd_colors() {
  local -n palette="$1"
  cat > "${SWAYOSD_COLORS_FILE}" <<PALETTE
@define-color background-color ${palette[surface_bg]};
@define-color border-color ${palette[accent_hex]};
@define-color label ${palette[fg]};
@define-color image ${palette[fg]};
@define-color progress ${palette[accent_hex]};
PALETTE
}

write_hyprlock_colors() {
  local -n palette="$1"
  cat > "${HYPRLOCK_COLORS_FILE}" <<PALETTE
\$color = rgba(13,17,24,0.92)
\$inner_color = rgba(23,30,42,0.86)
\$outer_color = rgba(${palette[r]},${palette[g]},${palette[b]},0.95)
\$font_color = rgba(234,240,248,1.0)
\$check_color = rgba(${palette[r]},${palette[g]},${palette[b]},1.0)
PALETTE
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

resolve_theme_source() {
  local -n selected_map="$1"
  local theme_source=""

  if [ -n "${selected_map[${LAPTOP_OUTPUT}]:-}" ]; then
    theme_source="${selected_map[${LAPTOP_OUTPUT}]}"
  else
    theme_source="$(read_current_wallpaper "${LAPTOP_OUTPUT}" || true)"
    if [ -z "${theme_source}" ] || [ ! -f "${theme_source}" ]; then
      theme_source="$(read_displayed_wallpaper "${LAPTOP_OUTPUT}" || true)"
    fi
  fi

  if [ -z "${theme_source}" ] || [ ! -f "${theme_source}" ]; then
    theme_source=""
    for output in "${!selected_map[@]}"; do
      if [ -f "${selected_map[${output}]}" ]; then
        theme_source="${selected_map[${output}]}"
        break
      fi
    done
  fi

  if [ -z "${theme_source}" ] || [ ! -f "${theme_source}" ]; then
    echo "Failed to determine theme source wallpaper" >&2
    exit 1
  fi

  printf '%s\n' "${theme_source}"
}

main() {
  local mode="random"
  local target=""
  local target_output=""

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
    --random-output)
      mode="random-output"
      target_output="${2:-}"
      if [ -z "${target_output}" ]; then
        usage
        exit 1
      fi
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

  require_cmd hyprctl
  require_cmd jq
  require_cmd swww
  require_cmd swww-daemon
  require_cmd magick
  require_cmd python3

  declare -A selected_wallpapers=()
  declare -a outputs=()

  mapfile -t outputs < <(connected_outputs)
  if [ "${#outputs[@]}" -eq 0 ]; then
    echo "No connected outputs detected" >&2
    exit 1
  fi

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

      for output in "${outputs[@]}"; do
        selected_wallpapers["${output}"]="${target}"
      done
      ;;
    random)
      for output in "${outputs[@]}"; do
        current="$(read_current_wallpaper "${output}" || true)"
        selected_wallpapers["${output}"]="$(pick_random_wallpaper "${current}")"
      done
      ;;
    reapply)
      for output in "${outputs[@]}"; do
        current="$(read_current_wallpaper "${output}" || true)"
        if [ -n "${current}" ] && [ -f "${current}" ]; then
          selected_wallpapers["${output}"]="${current}"
        else
          selected_wallpapers["${output}"]="$(pick_random_wallpaper "${current}")"
        fi
      done
      ;;
    random-output)
      if ! printf '%s\n' "${outputs[@]}" | grep -Fxq "${target_output}"; then
        echo "Output is not connected: ${target_output}" >&2
        exit 1
      fi

      current="$(read_current_wallpaper "${target_output}" || true)"
      selected_wallpapers["${target_output}"]="$(pick_random_wallpaper "${current}")"
      ;;
  esac

  ensure_swww_ready

  for output in "${!selected_wallpapers[@]}"; do
    swww img "${selected_wallpapers[${output}]}" \
      --outputs "${output}" \
      --transition-type grow \
      --transition-duration 1.1 \
      --transition-fps 60 >/dev/null

    write_current_wallpaper "${output}" "${selected_wallpapers[${output}]}"
  done

  theme_source="$(resolve_theme_source selected_wallpapers)"
  dominant_hex="$(extract_dominant_hex "${theme_source}")"
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
