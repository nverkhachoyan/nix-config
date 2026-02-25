# My nix config for macOS + Linux

This config uses a host matrix:
- macOS hosts use `nix-darwin` + Home Manager
- Linux hosts use standalone Home Manager (non-NixOS)

Some nice flakes like [nixvim](https://github.com/nix-community/nixvim) have simplified it further.

Apply macOS host config:

```sh
sudo darwin-rebuild switch --flake .#iloveyou
```

Apply Linux host config:

```sh
home-manager switch --flake .#nverk@workhorse
```
