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
      "gpg \"ssh\"".program = "${pkgs._1password-gui}/bin/op-ssh-sign";

      user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBoVotkT+jNCRAtiZM+tQSh/grcNL17yldLsy1OhnsSb";
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
