{
  description = "Mac config";

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
      username = "nverkhachoyan";
      system = "aarch64-darwin";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      darwinConfigurations."${username}-darwin" = darwin.lib.darwinSystem {
        inherit system pkgs;
        specialArgs = {
          inherit inputs username;
        };

        modules = [
          ./system/darwin
          home-manager.darwinModules.default
        ];
      };

      formatter.${system} = pkgs.nixfmt-tree;

      devShells.${system}.default = pkgs.mkShell {
        packages = [
          pkgs.git
          pkgs.nixfmt-tree
          darwin.packages.${system}.darwin-rebuild
        ];
      };

    };
}
