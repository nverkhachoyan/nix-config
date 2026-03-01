{ pkgs, ... }:
{
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "lock";
        action = "hyprlock";
        text = "Lock";
        keybind = "l";
      }
      {
        label = "suspend";
        action = "loginctl lock-session && systemctl suspend";
        text = "Suspend";
        keybind = "s";
      }
      {
        label = "logout";
        action = "hyprctl dispatch exit";
        text = "Logout";
        keybind = "e";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "p";
      }
      {
        label = "cancel";
        action = "pkill wlogout";
        text = "Cancel";
        keybind = "c";
      }
    ];
    style = builtins.replaceStrings [ "/usr/share/wlogout/icons" ] [ "${pkgs.wlogout}/share/wlogout/icons" ] (
      builtins.readFile ./files/wlogout/style.css
    );
  };
}
