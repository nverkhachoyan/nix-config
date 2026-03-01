{
  lib,
  host,
  pkgs,
  ...
}:
let
  shellPluginCommands = [
    "gh"
    "aws"
  ];

  mkPosixWrapper = command: ''
    ${command}() {
      op plugin run -- ${command} "$@"
    }
  '';

  mkFishWrapper = command: ''
    function ${command} --wraps "${command}" --description "1Password Shell Plugin for ${command}"
      op plugin run -- ${command} $argv
    end
  '';

  posixShellWrappers = lib.concatMapStringsSep "\n" mkPosixWrapper shellPluginCommands;
  fishShellWrappers = lib.concatMapStringsSep "\n" mkFishWrapper shellPluginCommands;
in
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
    OP_PLUGINS_SOURCED = "1";
  }
  // lib.optionalAttrs (host.platform == "darwin") {
    SSH_AUTH_SOCK = "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
  }
  // lib.optionalAttrs (host.platform == "linux") {
    SSH_AUTH_SOCK = "$HOME/.1password/agent.sock";
  };

  programs.bash.initExtra = posixShellWrappers;
  programs.zsh.initContent = posixShellWrappers;
  programs.fish.interactiveShellInit = fishShellWrappers;
}
