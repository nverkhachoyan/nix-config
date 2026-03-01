{ ... }:
{
  programs.bash = {
    enable = true;
    enableCompletion = true;

    initExtra = ''
      # Fall back to 1Password SSH agent socket if this shell did not inherit SSH_AUTH_SOCK.
      if [ -z "$SSH_AUTH_SOCK" ] && [ -S "$HOME/.1password/agent.sock" ]; then
        export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"
      fi

      # Readline key bindings (bash)
      # - Up/Down: search history by current prefix (similar vibe to zsh up-line-or-history)
      bind '"\e[A": history-search-backward'
      bind '"\e[B": history-search-forward'

      # - Ctrl+L: clear screen (usually default, but explicit is fine)
      bind '"\C-l": clear-screen'

      # Ensure Atuin integration is initialized after other prompt hooks.
      if command -v atuin >/dev/null 2>&1; then
        eval "$(atuin init bash)"
      fi
    '';
  };
}
