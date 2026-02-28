{ ... }:
{
  targets.genericLinux.enable = true;

  home.sessionVariables = {
    PNPM_HOME = "$HOME/.local/share/pnpm/store";
    QT_QPA_PLATFORMTHEME = "gtk3";
  };
}
