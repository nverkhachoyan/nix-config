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
