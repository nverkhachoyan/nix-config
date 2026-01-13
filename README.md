# My nix config for macOS

This is a fairly simple config using nix-darwin and the home manager module.

Some nice nix flakes like [nixvim](https://github.com/nix-community/nixvim) have simplified it even further.

Build by running

```sh
sudo darwin-rebuild switch --flake .#primary
```
