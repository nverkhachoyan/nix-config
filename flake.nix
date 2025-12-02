{
  description = "Mac + Linux config";

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
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      darwin,
      ...
    }:
    let
      username = "nverkhachoyan";
      system = "aarch64-darwin";
      root = self;
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      darwinConfigurations."${username}-darwin" = darwin.lib.darwinSystem {
        inherit system pkgs;
        specialArgs = {
          inherit
            username
            root
            nixpkgs
            home-manager
            darwin
            ;
        };

        modules = [
          home-manager.darwinModules.default
          ./system/darwin
        ];
      };

      formatter.${system} = pkgs.nixfmt-tree;

      devShells.${system}.default = pkgs.mkShell {
        packages = [
          pkgs.git
          pkgs.nixfmt-tree
          darwin.packages.${system}.darwin-rebuild
        ];
        shellHook = ''
          alias dr="darwin-rebuild switch --flake .#${username}-darwin"
        '';
      };

      checks.${system}.fmt =
        pkgs.runCommand "fmt-check"
          {
            nativeBuildInputs = [ pkgs.nixfmt-tree ];
            src = self;
          }
          ''
            cd "$src"
            treefmt --ci .
            touch "$out"
          '';
    };
}
