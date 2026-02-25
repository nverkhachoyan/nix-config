{
  pkgs,
  username,
  homeDirectory ? null,
  ...
}:

let
  resolvedHomeDirectory =
    if homeDirectory != null then
      homeDirectory
    else if pkgs.stdenv.isDarwin then
      "/Users/${username}"
    else
      "/home/${username}";
in

{
  imports = [
    ./platform
    ./programs
    ./services
    ./packages.nix
  ];

  home.username = username;
  home.homeDirectory = resolvedHomeDirectory;
  home.stateVersion = "24.05";

  home.sessionVariables = {
    PATH = "$PATH:$HOME/.npm-global/bin";
  };

  xdg.enable = true;
  programs.home-manager.enable = true;
}
