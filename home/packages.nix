{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # general tools
    btop
    nil
    zoxide
    bat
    fzf
    fd
    ripgrep
    eza
    yt-dlp
    nmap
    tree-sitter

    # Devops
    terraform
    awscli2
    act
    k3sup
    kubernetes-helm

    # Pkg managers & runtimes
    nodejs_24
    pnpm
    uv
    cargo
    go

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
    nodePackages.prettier
    rustfmt
    # Nix
    nixfmt-tree
  ];
}
