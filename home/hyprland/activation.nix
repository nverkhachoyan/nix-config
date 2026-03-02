{ lib, ... }:
{
  home.activation.hyprlandThemeBootstrap = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        mkdir -p "$HOME/.config/waybar" "$HOME/.config/walker" "$HOME/.config/wlogout" "$HOME/.config/swayosd" "$HOME/.config/hypr"

        if [ ! -e "$HOME/.config/waybar/colors.css" ]; then
          cat > "$HOME/.config/waybar/colors.css" <<'EOT'
    @define-color accent #cc3c2f;
    @define-color accent_light #db766d;
    @define-color accent_dark #85271f;
    @define-color accent_soft rgba(204,60,47,0.24);
    @define-color accent_strong rgba(204,60,47,0.36);
    @define-color accent_border rgba(204,60,47,0.44);
    @define-color accent_glow rgba(204,60,47,0.24);
    @define-color accent_text #f5f9ff;
    @define-color glass_bg rgba(11,15,21,0.72);
    @define-color glass_chip rgba(255,255,255,0.08);
    @define-color module_bg rgba(255,255,255,0.07);
    @define-color module_bg_hover rgba(255,255,255,0.12);
    @define-color surface_bg rgba(13,17,24,0.94);
    @define-color overlay_bg rgba(8,10,14,0.62);
    @define-color fg #eaf0f8;
    @define-color muted #b7c4d6;
    @define-color critical #f87171;
    @define-color warning #fbbf24;
    EOT
        fi

        if [ ! -e "$HOME/.config/walker/theme-colors.css" ]; then
          cat > "$HOME/.config/walker/theme-colors.css" <<'EOT'
    @define-color foreground #eaf0f8;
    @define-color muted #b7c4d6;
    @define-color background rgba(13,17,24,0.94);
    @define-color chip rgba(255,255,255,0.07);
    @define-color accent #cc3c2f;
    @define-color accent_soft rgba(204,60,47,0.24);
    @define-color accent_text #f5f9ff;
    @define-color border rgba(204,60,47,0.44);
    EOT
        fi

        if [ ! -e "$HOME/.config/wlogout/theme-colors.css" ]; then
          cat > "$HOME/.config/wlogout/theme-colors.css" <<'EOT'
    @define-color foreground #eaf0f8;
    @define-color background rgba(8,10,14,0.62);
    @define-color card rgba(13,17,24,0.94);
    @define-color card_hover rgba(255,255,255,0.12);
    @define-color accent #cc3c2f;
    @define-color accent_soft rgba(204,60,47,0.24);
    @define-color border rgba(204,60,47,0.44);
    @define-color danger #f87171;
    EOT
        fi

        if [ ! -e "$HOME/.config/swayosd/theme-colors.css" ]; then
          cat > "$HOME/.config/swayosd/theme-colors.css" <<'EOT'
    @define-color background-color rgba(13,17,24,0.94);
    @define-color border-color #cc3c2f;
    @define-color label #eaf0f8;
    @define-color image #eaf0f8;
    @define-color progress #cc3c2f;
    EOT
        fi

        if [ ! -e "$HOME/.config/hypr/hyprlock-colors.conf" ]; then
          cat > "$HOME/.config/hypr/hyprlock-colors.conf" <<'EOT'
    $color = rgba(13,17,24,0.92)
    $inner_color = rgba(23,30,42,0.86)
    $outer_color = rgba(204,60,47,0.95)
    $font_color = rgba(234,240,248,1.0)
    $check_color = rgba(204,60,47,1.0)
    EOT
        fi
  '';
}
