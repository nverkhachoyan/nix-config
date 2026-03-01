{
  lib,
  host,
  pkgs,
  ...
}:
{
  imports =
    [ ]
    ++ lib.optionals (host.platform == "darwin") [
      ./darwin.nix
    ]
    ++ lib.optionals (host.platform == "linux") [
      ./linux.nix
    ];

  home.packages = with pkgs; [
    _1password-gui
    _1password-cli
  ];

  home.sessionVariables = {
  }
  // lib.optionalAttrs (host.platform == "darwin") {
    SSH_AUTH_SOCK = "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
  }
  // lib.optionalAttrs (host.platform == "linux") {
    SSH_AUTH_SOCK = "$HOME/.1password/agent.sock";
  };

  programs._1password-shell-plugins = {
    enable = true;
    package = pkgs._1password-cli;
    plugins = with pkgs; [
      awscli2
    ];
  };
}
