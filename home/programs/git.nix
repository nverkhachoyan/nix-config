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
    };

    settings = {
      init.defaultBranch = "main";
      pull.rebase = true;
      rebase.autoStash = true;

      gpg.format = "ssh";
      "gpg \"ssh\"".program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
      commit.gpgsign = true;

      user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBoVotkT+jNCRAtiZM+tQSh/grcNL17yldLsy1OhnsSb";
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };
}
