{ ... }:

{
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      init.defaultBranch = "main";
      pull.rebase = true;
      rebase.autoStash = true;
      credential.helper = "osxkeychain";
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };
}
