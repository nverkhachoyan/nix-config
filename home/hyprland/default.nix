{ lib, host, ... }:
{
  imports = lib.optionals (host.platform == "linux") [
    ./packages.nix
    ./hyprland.nix
    ./waybar.nix
    ./wlogout.nix
    ./systemd.nix
    ./files.nix
    ./activation.nix
  ];
}
