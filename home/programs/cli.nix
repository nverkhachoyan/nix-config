{ pkgs, ... }:

{
  programs.bat = {
    enable = true;
  };

  programs.eza = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    icons = "auto";
    git = true;
  };

  programs.direnv = {
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

  programs.lazydocker = {
    enable = true;
    package = pkgs.lazydocker;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    tmux.enableShellIntegration = true;
  };

  programs.yt-dlp = {
    enable = true;
  };
}
