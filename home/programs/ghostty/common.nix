{ pkgs, ... }:

let
  inherit (pkgs.stdenv) isDarwin;
in

{
  programs.ghostty = {
    enable = true;
    package = if isDarwin then null else pkgs.ghostty;
    settings = {
      # Font settings
      "font-family" = "JetBrainsMono Nerd Font Mono";
      "font-size" = 20;

      # smooth-reading features
      "font-feature" = [
        "-calt"
        "-liga"
      ];
      "font-thicken" = true;

      # --- Window & Appearance ---
      "window-theme" = "dark";
      "background-blur" = 20;
      "window-padding-x" = 12;
      "window-padding-y" = 12;

      # --- Behavior ---
      maximize = true;
      "copy-on-select" = true;
      "mouse-hide-while-typing" = true;
      "confirm-close-surface" = true;
      "shell-integration" = "detect";

      # --- Cursor ---
      "cursor-style" = "block";
      "cursor-style-blink" = true;
      "cursor-color" = "#d4d4d4";
      "cursor-text" = "#000000";
    };
  };
}
