{ pkgs, ... }:
{
  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    HOMEBREW_NO_ENV_HINTS = "1";
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.droid-sans-mono
  ];

  security.pam.services.sudo_local.touchIdAuth = true;
}
