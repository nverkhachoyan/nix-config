{ lib, pkgs, ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."*" = {
      controlMaster = "auto";
      controlPersist = "10m";
      serverAliveInterval = 60;
      serverAliveCountMax = 3;
      extraOptions = {
        AddKeysToAgent = "yes";
      }
      // lib.optionalAttrs pkgs.stdenv.isDarwin {
        IdentityAgent = "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
      }
      // lib.optionalAttrs pkgs.stdenv.isLinux {
        IdentityAgent = "~/.1password/agent.sock";
      }
      // lib.optionalAttrs pkgs.stdenv.isDarwin {
        UseKeychain = "yes";
      };
    };
  };
}
