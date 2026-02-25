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
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      darwin,
      ...
    }:
    let
      lib = nixpkgs.lib;
      username = "nverk";
      hosts = {
        iloveyou = {
          kind = "darwin";
          system = "aarch64-darwin";
          homeDirectory = "/Users/${username}";
        };

        workhorse = {
          kind = "home-manager";
          system = "x86_64-linux";
          homeDirectory = "/home/${username}";
        };
      };

      mkPkgs =
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = lib.optionals (lib.hasSuffix "darwin" system) [
            (final: prev: {
              python313Packages = prev.python313Packages.overrideScope (
                pyFinal: pyPrev: {
                  # yt-dlp deps pull jeepney, and it fails on Darwin (jeepney uses dbus, which is not available on Darwin)
                  # Disabling D-Bus check for jeepney for now
                  jeepney = pyPrev.jeepney.overridePythonAttrs (_: {
                    doCheck = false;
                    pythonImportsCheck = [ ];
                  });
                }
              );
            })
          ];
        };

      mkHost = hostName: host: host // { name = hostName; };

      darwinHosts = lib.mapAttrs mkHost (lib.filterAttrs (_: host: host.kind == "darwin") hosts);
      hmHosts = lib.mapAttrs mkHost (lib.filterAttrs (_: host: host.kind == "home-manager") hosts);

      allSystems = lib.unique (map (host: host.system) (lib.attrValues hosts));
      forAllSystems = f: lib.genAttrs allSystems f;
    in
    {
      darwinConfigurations = lib.mapAttrs (
        _hostName: host:
        darwin.lib.darwinSystem {
          system = host.system;
          pkgs = mkPkgs host.system;
          specialArgs = {
            inherit inputs username host;
          };

          modules = [
            ./darwin
            home-manager.darwinModules.default
          ];
        }
      ) darwinHosts;

      homeConfigurations = lib.mapAttrs' (
        hostName: host:
        lib.nameValuePair "${username}@${hostName}" (
          home-manager.lib.homeManagerConfiguration {
            pkgs = mkPkgs host.system;
            extraSpecialArgs = {
              inherit inputs username host;
              homeDirectory = host.homeDirectory;
            };
            modules = [
              inputs.nixvim.homeModules.nixvim
              ./home
            ];
          }
        )
      ) hmHosts;

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
