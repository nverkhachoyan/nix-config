{ lib, host, ... }:
{
  imports = [
    ./common.nix
  ]
  ++ lib.optionals (host.platform == "darwin") [
    ./darwin.nix
  ];
}
