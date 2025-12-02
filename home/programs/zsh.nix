{ ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    shellAliases = {
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
      cd = "z";
      dev = "cd ~/projects/";
      ".." = "cd ..";
      "..." = "cd ../..";
    };

    initContent = ''
      # lt function (tree view with level parameter)
      lt() {
        eza --sort=type --tree --level "''${1:-2}"
      }

      # Key bindings
      bindkey '^[[A' up-line-or-history
      bindkey '^[[B' down-line-or-history
      bindkey '^R' history-incremental-search-backward
      bindkey '^L' clear-screen
    '';
  };

}
