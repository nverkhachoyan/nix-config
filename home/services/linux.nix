{ lib, host, ... }:
lib.mkIf (host.platform == "linux") {
  home.sessionVariables = {
    SSH_AUTH_SOCK = "$HOME/.1password/agent.sock";
  };
}
