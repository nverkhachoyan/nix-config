{ ... }:

{
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      user = {
        name = "Nver Khachoyan";
        email = "khachoyannver@gmail.com";
      };
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
