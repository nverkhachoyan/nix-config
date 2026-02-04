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
    ./programs/gh.nix
    ./programs/git.nix
    ./programs/ssh.nix
    ./packages.nix
  ];

  home.username = username;
  home.homeDirectory = "/Users/${username}";
  home.stateVersion = "24.05";

  home.sessionVariables = {
    # SSH_AUTH_SOCK = "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
    PATH = "$PATH:$HOME/.npm-global/bin";
  };

  launchd.agents."com.1password.SSH_AUTH_SOCK" = {
    enable = true;
    config = {
      Label = "com.1password.SSH_AUTH_SOCK";
      ProgramArguments = [
        "/bin/sh"
        "-c"
        ''/bin/ln -sf "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock" "$SSH_AUTH_SOCK"''
      ];
      RunAtLoad = true;
    };

  };

  xdg.enable = true;
  programs.home-manager.enable = true;
}
