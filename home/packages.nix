{ pkgs, ... }:
{
  home.packages = with pkgs; [
    btop
    nil
    zoxide
    bat
    fzf
    ripgrep
    eza

    # LSP
    lua-language-server
    nodePackages.typescript-language-server
    rust-analyzer
    gopls
    clang-tools # clangd
    nixd # Nix LSP
    uv

    # Formatters & linters
    stylua
    vale
    python3Packages.pylint
    # Nix
    nixfmt-rfc-style
    statix
  ];
}
