{ config, ... }:
{
  targets.genericLinux.enable = true;

  home.sessionVariables = {
    PNPM_HOME = "$HOME/.local/share/pnpm/store";
    QT_QPA_PLATFORMTHEME = "gtk3";
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop = "${config.home.homeDirectory}/Desktop";
    documents = "${config.home.homeDirectory}/Docs";
    download = "${config.home.homeDirectory}/Downloads";

    # Hide the clutter inside Docs :D
    music = "${config.home.homeDirectory}/Docs";
    pictures = "${config.home.homeDirectory}/Docs/Pictures";
    videos = "${config.home.homeDirectory}/Docs/Videos";
    templates = "${config.home.homeDirectory}/Docs/Templates";
    publicShare = "${config.home.homeDirectory}/Docs/Public";

    extraConfig = {
      DEV = "${config.home.homeDirectory}/Dev";
    };
  };

}
