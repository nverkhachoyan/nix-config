{ lib, host, ... }:
{
  imports = lib.optionals (host.platform == "darwin") [
    ./1password.nix
  ];
}
