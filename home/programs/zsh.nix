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
      # Ensure 1Password SSH agent socket is available in interactive shells
      if [ -S "$HOME/.1password/agent.sock" ]; then
        export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"
      elif [ -S "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock" ]; then
        export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
      fi

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
