{
  lib,
  host,
  username,
  ...
}:

let
  flakePath = "~/Dev/personal/nix-config";
  rebuildCmd =
    if host.manager == "darwin" then
      "sudo darwin-rebuild switch --flake ${flakePath}#${host.name}"
    else
      "home-manager switch --flake ${flakePath}#${username}@${host.name}";
in
{
  home.shellAliases = {
    rebuild = rebuildCmd;
    nv = "nvim";
    ls = "eza --sort=type --icons --hyperlink --time-style relative --no-user --no-permissions";
    ll = "eza -lah --sort=type --icons --hyperlink --time-style relative";
    la = "ls -A";
    cat = "bat";
    gst = "git status";
    gcm = "git commit -m";
    ga = "git add";
    gaa = "git add --all";
    gfp = "git fetch && git pull";
    dc = "docker compose";
    dps = ''docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}"'';
    aws = "op plugin run -- aws";
    nclean = "nh clean all --keep 7d";
    c = "z";
    dev = "cd ~/Dev/";
    code = "code --extensions-dir ~/.config/vscode/extensions --user-data-dir ~/.config/vscode/data";
    ".." = "cd ..";
    "..." = "cd ../..";

  }
  // lib.optionalAttrs (host.manager == "darwin") {
    dr = "sudo darwin-rebuild switch --flake ${flakePath}#${host.name}";
  }
  // lib.optionalAttrs (host.manager == "home-manager") {
    hr = "home-manager switch --flake ${flakePath}#${username}@${host.name}";
  };
}
