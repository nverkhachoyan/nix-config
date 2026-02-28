{ lib, pkgs, ... }:

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

      gpg.format = "ssh";
      commit.gpgsign = true;

      user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBoVotkT+jNCRAtiZM+tQSh/grcNL17yldLsy1OhnsSb";
    }
    // lib.optionalAttrs pkgs.stdenv.isDarwin {
      "gpg \"ssh\"".program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
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
