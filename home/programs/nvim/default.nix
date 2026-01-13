{ ... }:

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

    extraConfigLuaPost = builtins.readFile ./lua/lualine.lua;
  };
}
