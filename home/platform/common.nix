_:
{
  home.sessionVariables = {
    VSCODE_PORTABLE = "$HOME/.config/vscode";
    NPM_CONFIG_USERCONFIG = "$HOME/.config/npm/npmrc";
    NODE_REPL_HISTORY = "$HOME/.local/share/node_history";
    DOTNET_CLI_HOME = "$HOME/.local/share/dotnet";
    GOPATH = "$HOME/Dev/go";
    CARGO_HOME = "$HOME/.local/share/cargo";
  };

  home.sessionPath = [
    "$HOME/.local/share/npm-global/bin"
    "$HOME/Dev/go/bin"
  ];
}
