{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;

    prefix = "C-Space";
    baseIndex = 1;
    escapeTime = 0;
    historyLimit = 50000;
    mouse = true;
    aggressiveResize = false;
    terminal = "tmux-256color";
    keyMode = "vi";

    # sensibleOnTop runs sensible plugin before custom conf
    sensibleOnTop = true;

    plugins = with pkgs; [
      tmuxPlugins.dracula
    ];

    extraConfig = builtins.readFile ./tmux.conf;
  };

  programs.sesh = {
    enable = true;
    enableAlias = true;
    icons = true;
    enableTmuxIntegration = true;
  };
}
