{
  pkgs,
  ...
}:
{
  imports = [
    ./darwin.nix
    ./linux.nix
  ];

  home.packages = with pkgs; [
    _1password-cli
  ];
}
