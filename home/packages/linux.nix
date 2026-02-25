{ lib, pkgs, ... }:
lib.mkIf pkgs.stdenv.isLinux {
  home.packages = with pkgs; [
    # Clipboard and desktop integration helpers
    wl-clipboard
    xclip
    xdg-utils
  ];
}
