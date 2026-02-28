{ lib, host, ... }:
{
  imports = [
    ./common.nix
  ]
  ++ lib.optionals (host.platform == "linux") [
    ./linux.nix
  ];
}
