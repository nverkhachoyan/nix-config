{ lib, pkgs, ... }:
lib.mkIf pkgs.stdenv.isDarwin {
  programs.alacritty.settings.window = {
    blur = true;
    option_as_alt = "Both";
  };
}
