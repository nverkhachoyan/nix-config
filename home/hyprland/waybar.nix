_:
let
  configJson = builtins.readFile ./files/waybar/config.json;
in
{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "hyprland-session.target";
    };
    settings = [ (builtins.fromJSON configJson) ];
    style = builtins.readFile ./files/waybar/style.css;
  };
}
