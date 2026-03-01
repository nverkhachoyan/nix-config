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

  home = {
    inherit username homeDirectory;
    stateVersion = "24.05";
    enableNixpkgsReleaseCheck = false;
  };

  xdg.enable = true;
  programs.home-manager.enable = true;
}
