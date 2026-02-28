{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.droid-sans-mono

    # Clipboard and desktop integration helpers
    wl-clipboard
    xclip
    xdg-utils
  ];
}
