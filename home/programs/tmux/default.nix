{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.dracula
    ];

    extraConfig = builtins.readFile ./tmux.conf;
  };
}
