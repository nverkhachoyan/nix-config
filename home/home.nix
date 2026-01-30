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

  home.sessionVariables = {
  SSH_AUTH_SOCK = "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
};

  xdg.enable = true;
  programs.home-manager.enable = true;
}
