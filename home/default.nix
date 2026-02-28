{
  host,
  username,
  homeDirectory ? host.homeDirectory,
  ...
}:
{
  imports = [
    ./platform
    ./programs
    ./services
    ./packages
  ];

  home.username = username;
  home.homeDirectory = homeDirectory;
  home.stateVersion = "24.05";

  xdg.enable = true;
  programs.home-manager.enable = true;
}
