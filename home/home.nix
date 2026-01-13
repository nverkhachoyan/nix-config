{ username, ... }:

{
  imports = [
    ./programs/nvim
    ./programs/tmux
    ./programs/zsh.nix
    ./programs/cli.nix
    ./programs/starship.nix
    ./programs/alacritty.nix
    ./programs/ghostty.nix
    ./programs/git.nix
    ./programs/ssh.nix
    ./packages.nix
  ];

  home.username = username;
  home.homeDirectory = "/Users/${username}";
  home.stateVersion = "24.05";

  xdg.enable = true;
  programs.home-manager.enable = true;
}
