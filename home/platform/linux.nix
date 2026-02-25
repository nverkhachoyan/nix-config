{ lib, pkgs, ... }:
lib.mkIf pkgs.stdenv.isLinux {
  targets.genericLinux.enable = true;
}
