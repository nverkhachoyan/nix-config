{
  ...
}:
{
  programs.bash = {
    enable = true;
    enableCompletion = true;

    initExtra = ''
      # lt function (tree view with level parameter)
      lt() {
        eza --sort=type --tree --level "''${1:-2}"
      }

      # Readline key bindings (bash)
      # - Up/Down: search history by current prefix (similar vibe to zsh up-line-or-history)
      bind '"\e[A": history-search-backward'
      bind '"\e[B": history-search-forward'

      # - Ctrl+R: incremental reverse search (default in many distros, but explicit is fine)
      bind '"\C-r": reverse-search-history'

      # - Ctrl+L: clear screen (usually default, but explicit is fine)
      bind '"\C-l": clear-screen'
    '';
  };
}
