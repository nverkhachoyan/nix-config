{ username, ... }:

{
  imports = [
    ./programs
    ./services
    ./packages.nix
  ];

  home.username = username;
  home.homeDirectory = "/Users/${username}";
  home.stateVersion = "24.05";

  home.sessionVariables = {
    PATH = "$PATH:$HOME/.npm-global/bin";
  };

  xdg.enable = true;
  programs.home-manager.enable = true;
}
