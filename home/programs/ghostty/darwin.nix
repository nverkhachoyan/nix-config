{ lib, pkgs, ... }:
lib.mkIf pkgs.stdenv.isDarwin {
  programs.ghostty.settings = {
    # Clean up the macOS header
    "macos-titlebar-style" = "tabs";
    "macos-titlebar-proxy-icon" = "hidden";
    "macos-option-as-alt" = true;
  };
}
