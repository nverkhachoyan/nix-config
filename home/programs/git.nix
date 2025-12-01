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
      alias = {
        gst = "status";
        gcm = "commit -m";
        ga = "add";
        gaa = "add --all";
        gp = "push";
        rb = "rebase";
        d = "diff";
        f = "fetch";
        pl = "pull";
      };
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };
}


# warning: Git tree '/Users/nverkhachoyan/Play/nix' is dirty
# trace: warning: nverkhachoyan profile: The option `programs.git.aliases' defined in `/nix/store/2jalxw3zdpvy87gm8w5bm3jqw4wpbj1c-source/home/programs/git.nix' has been renamed to `programs.git.settings.alias'.
# trace: warning: nverkhachoyan profile: The option `programs.git.userEmail' defined in `/nix/store/2jalxw3zdpvy87gm8w5bm3jqw4wpbj1c-source/home/programs/git.nix' has been renamed to `programs.git.settings.user.email'.
# trace: warning: nverkhachoyan profile: The option `programs.git.userName' defined in `/nix/store/2jalxw3zdpvy87gm8w5bm3jqw4wpbj1c-source/home/programs/git.nix' has been renamed to `programs.git.settings.user.name'.
