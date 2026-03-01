{
  ...
}:

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
      pull.ff = "only";
      fetch.prune = true;
      rebase.autoStash = true;
      merge.conflictstyle = "zdiff3";
      commit.gpgsign = false;
    };
  };

  programs.lazygit = {
    enable = true;
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };
}
