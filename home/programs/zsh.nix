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
      # Fall back to 1Password SSH agent socket if this shell did not inherit SSH_AUTH_SOCK.
      if [[ -z "$SSH_AUTH_SOCK" && -S "$HOME/.1password/agent.sock" ]]; then
        export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"
      fi

      # Key bindings
      bindkey '^[[A' up-line-or-history
      bindkey '^[[B' down-line-or-history
      bindkey '^R' history-incremental-search-backward
      bindkey '^L' clear-screen
    '';
  };

}
