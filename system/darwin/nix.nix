{
  root,
  nixpkgs,
  home-manager,
  darwin,
  username,
  ...
}:

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
      self.flake = root;
      nixpkgs.flake = nixpkgs;
      home-manager.flake = home-manager;
      darwin.flake = darwin;
    };

    nixPath = [
      "nixpkgs=${nixpkgs.outPath}"
      "home-manager=${home-manager.outPath}"
      "darwin=${darwin.outPath}"
      "self=${root.outPath}"
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
