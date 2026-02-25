{ inputs, username, ... }:

let
  inherit (inputs)
    self
    nixpkgs
    home-manager
    darwin
    ;
in
{
  nix = {
    optimise.automatic = true;

    settings = {
      trusted-users = [
        "root"
        "${username}"
      ];
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FgjGCEPvqV3AE0teVqz4nJrQC3B+bJJ5Y7eGErSM="
      ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
    };

    registry = {
      self.flake = self;
      nixpkgs.flake = nixpkgs;
      home-manager.flake = home-manager;
      darwin.flake = darwin;
    };

    nixPath = [
      "nixpkgs=${nixpkgs.outPath}"
      "home-manager=${home-manager.outPath}"
      "darwin=${darwin.outPath}"
      "self=${self.outPath}"
    ];

    gc = {
      automatic = true;
      interval = {
        Weekday = 0;
        Hour = 2;
        Minute = 0;
      };
      options = "--delete-older-than 7d";
    };
  };
}
