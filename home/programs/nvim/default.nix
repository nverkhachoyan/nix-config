{ pkgs, ... }:

{
  imports = [
    ./keymaps.nix
    ./options.nix
    ./theme.nix
    ./plugins.nix
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    globals = {
      mapleader = " ";
      maplocalleader = "\\";
    };

    extraPackages = with pkgs; [
      nixfmt-tree
      nodePackages.prettier
      rustfmt
      fd
      tree-sitter
    ];

    extraConfigLuaPost = builtins.readFile ./lua/lualine.lua;
  };
}
