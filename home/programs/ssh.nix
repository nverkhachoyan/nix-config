{ ... }:

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
        UseKeychain = "yes";
      };
    };
  };
}
