{ root, pkgs, ... }:

let
  treesitter = pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
    p.lua
    p.javascript
    p.typescript
    p.rust
    p.c_sharp
    p.gdscript
    p.go
    p.python
    p.nix
  ]);
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim
      telescope-nvim
      plenary-nvim
      nvim-tree-lua
      nvim-web-devicons
      lualine-nvim
      trouble-nvim
      nvim-surround
      nvim-lint
      nvim-cmp
      cmp-nvim-lsp
      luasnip
      nvim-lspconfig
      mason-nvim
      mason-lspconfig-nvim
      treesitter
    ];
  };

  xdg.configFile."nvim" = {
    source = "${root}/config/nvim";
    recursive = true;
  };
}
