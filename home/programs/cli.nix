{ pkgs, ... }:

{
  programs = {
    bat = {
      enable = true;
    };

    eza = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      icons = "auto";
      git = true;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
      config = {
        global = {
          load_dotenv = true;
          hide_env_diff = true;
        };
      };
    };

    lazydocker = {
      enable = true;
      package = pkgs.lazydocker;
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      tmux.enableShellIntegration = true;
    };

    yt-dlp = {
      enable = true;
    };
  };
}
