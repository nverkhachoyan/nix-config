{ host, ... }:

let
  hostModule = ./. + "/${host.name}.nix";
in
assert builtins.pathExists hostModule;
{
  imports = [ hostModule ];
}
