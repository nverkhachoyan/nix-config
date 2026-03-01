{ lib, host, ... }:
lib.mkIf (host.platform == "darwin") {
  home.sessionVariables = {
    SSH_AUTH_SOCK = "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
  };
}
