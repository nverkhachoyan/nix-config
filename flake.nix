{
  description = "Personal Nix config for macOS and Linux";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FgjGCEPvqV3AE0teVqz4nJrQC3B+bJJ5Y7eGErSM="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
    };
    onepassword-shell-plugins = {
      url = "github:1Password/shell-plugins";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      darwin,
      ...
    }:
    let
      inherit (nixpkgs) lib;
      username = "nverk";
      iloveyou = {
        name = "iloveyou";
        platform = "darwin";
        manager = "darwin";
        system = "aarch64-darwin";
        homeDirectory = "/Users/${username}";
      };

      workhorse = {
        name = "workhorse";
        platform = "linux";
        manager = "home-manager";
        system = "x86_64-linux";
        homeDirectory = "/home/${username}";
      };

      systems = lib.unique [
        iloveyou.system
        workhorse.system
      ];
      forAllSystems = lib.genAttrs systems;

      darwinOverlays = [
        (import ./overlays/darwin-python.nix)
      ];

      mkPkgs =
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = lib.optionals (lib.hasSuffix "darwin" system) darwinOverlays;
        };

      mkDarwinConfiguration =
        host:
        darwin.lib.darwinSystem {
          inherit (host) system;
          pkgs = mkPkgs host.system;
          specialArgs = {
            inherit inputs username host;
          };
          modules = [
            ./darwin
            home-manager.darwinModules.default
          ];
        };

      mkHomeConfiguration =
        host:
        home-manager.lib.homeManagerConfiguration {
          pkgs = mkPkgs host.system;
          extraSpecialArgs = {
            inherit inputs username host;
            inherit (host) homeDirectory;
          };
          modules = [
            inputs.nixvim.homeModules.nixvim
            ./home
          ];
        };
    in
    {
      darwinConfigurations.iloveyou = mkDarwinConfiguration iloveyou;
      homeConfigurations."${username}@workhorse" = mkHomeConfiguration workhorse;

      formatter = forAllSystems (system: (mkPkgs system).nixfmt-tree);

      devShells = forAllSystems (
        system:
        let
          pkgs = mkPkgs system;
        in
        {
          default = pkgs.mkShell {
            packages = [
              pkgs.git
              pkgs.nixfmt-tree
              home-manager.packages.${system}.default
            ]
            ++ lib.optionals (lib.hasSuffix "darwin" system) [
              darwin.packages.${system}.darwin-rebuild
            ];
          };
        }
      );

    };
}
