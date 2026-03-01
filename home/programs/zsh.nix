{
  config,
  ...
}:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    dotDir = "${config.xdg.configHome}/zsh";

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
