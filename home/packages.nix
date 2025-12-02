{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # general tools
    btop
    nil
    zoxide
    bat
    fzf
    ripgrep
    eza


    # Pkg managers & runtimes
    nodejs_24
    uv
    cargo

    # LSP
    lua-language-server
    nodePackages.typescript-language-server
    rust-analyzer
    gopls
    clang-tools
    nixd

    # Formatters & linters
    stylua
    vale
    python3Packages.pylint
    # Nix
    nixfmt-tree
  ];
}
