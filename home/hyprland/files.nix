{ config, ... }:
let
  mkSource = source: { inherit source; };

  mkExec = source: {
    inherit source;
    executable = true;
  };
in
{
  xdg.configFile = {
    "hypr/envs.conf" = mkSource ./files/hypr/envs.conf;
    "hypr/looknfeel.conf" = mkSource ./files/hypr/looknfeel.conf;
    "hypr/input.conf" = mkSource ./files/hypr/input.conf;
    "hypr/windows.conf" = mkSource ./files/hypr/windows.conf;
    "hypr/bindings.conf" = mkSource ./files/hypr/bindings.conf;
    "hypr/autostart.conf" = mkSource ./files/hypr/autostart.conf;
    "hypr/hypridle.conf" = mkSource ./files/hypr/hypridle.conf;
    "hypr/hyprlock.conf" = mkSource ./files/hypr/hyprlock.conf;
    "hypr/hyprsunset.conf" = mkSource ./files/hypr/hyprsunset.conf;

    "hypr/scripts/launch-apps.sh" = mkExec ./files/hypr/scripts/launch-apps.sh;
    "hypr/scripts/launcher.sh" = mkExec ./files/hypr/scripts/launcher.sh;
    "hypr/scripts/powermenu.sh" = mkExec ./files/hypr/scripts/powermenu.sh;
    "hypr/scripts/quick-settings.sh" = mkExec ./files/hypr/scripts/quick-settings.sh;
    "hypr/scripts/theme-wallpaper.sh" = mkExec ./files/hypr/scripts/theme-wallpaper.sh;
    "hypr/scripts/toggle-dnd.sh" = mkExec ./files/hypr/scripts/toggle-dnd.sh;
    "hypr/scripts/toggle-idle.sh" = mkExec ./files/hypr/scripts/toggle-idle.sh;
    "hypr/scripts/toggle-nightlight.sh" = mkExec ./files/hypr/scripts/toggle-nightlight.sh;
    "hypr/scripts/wallpaper-rotate.sh" = mkExec ./files/hypr/scripts/wallpaper-rotate.sh;
    "hypr/scripts/waybar-indicator-dnd.sh" = mkExec ./files/hypr/scripts/waybar-indicator-dnd.sh;
    "hypr/scripts/waybar-indicator-idle.sh" = mkExec ./files/hypr/scripts/waybar-indicator-idle.sh;
    "hypr/scripts/waybar-indicator-nightlight.sh" = mkExec ./files/hypr/scripts/waybar-indicator-nightlight.sh;
    "hypr/scripts/waybar-indicator-recording.sh" = mkExec ./files/hypr/scripts/waybar-indicator-recording.sh;

    "walker/config.toml" = {
      text = builtins.replaceStrings [ "@HOME@" ] [ config.home.homeDirectory ] (
        builtins.readFile ./files/walker/config.toml
      );
    };
    "walker/themes/omarchy-default/layout.xml" = mkSource ./files/walker/themes/omarchy-default/layout.xml;
    "walker/themes/omarchy-default/style.css" = mkSource ./files/walker/themes/omarchy-default/style.css;

    "wofi/launcher.conf" = mkSource ./files/wofi/launcher.conf;
    "wofi/launcher.css" = mkSource ./files/wofi/launcher.css;
    "wofi/quick-settings.conf" = mkSource ./files/wofi/quick-settings.conf;
    "wofi/quick-settings.css" = mkSource ./files/wofi/quick-settings.css;
    "wofi/powermenu.css" = mkSource ./files/wofi/powermenu.css;

    "swayosd/config.toml" = mkSource ./files/swayosd/config.toml;
    "swayosd/style.css" = mkSource ./files/swayosd/style.css;
  };
}
