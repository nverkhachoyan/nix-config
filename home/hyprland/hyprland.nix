{
  ...
}:
{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd = {
      enable = true;
    };
    extraConfig = builtins.readFile ./files/hypr/hyprland.conf;
  };
}
