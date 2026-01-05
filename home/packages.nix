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
    yt-dlp
    nmap

    # Devops
    terraform
    awscli2
    act
    k3sup

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
    # Nix
    nixfmt-tree
  ];
}
