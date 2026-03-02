{
  ...
}:
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    systemd = {
      enable = true;
    };
    extraConfig = builtins.readFile ./files/hypr/hyprland.conf;
  };

  xdg.portal = {
    enable = true;
    config = {
      common = {
        default = [
          "hyprland"
          "gtk"
        ];
      };
    };
  };

}
