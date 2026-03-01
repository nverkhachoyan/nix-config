{
  config,
  lib,
  ...
}:
{
  home.sessionVariables = {
    VSCODE_PORTABLE = "$HOME/.config/vscode";
    NPM_CONFIG_USERCONFIG = "$HOME/.config/npm/npmrc";
    NPM_CONFIG_PREFIX = "${config.home.homeDirectory}/.local/share/npm-global";
    NODE_REPL_HISTORY = "$HOME/.local/share/node_history";
    DOTNET_CLI_HOME = "$HOME/.local/share/dotnet";
    GOPATH = "$HOME/Dev/go";
    CARGO_HOME = "$HOME/.local/share/cargo";
  };

  xdg.configFile."npm/npmrc".text = ''
    prefix=${config.home.homeDirectory}/.local/share/npm-global
  '';

  home.file.".npmrc".text = ''
    prefix=${config.home.homeDirectory}/.local/share/npm-global
  '';

  home.activation.npmGlobalCompat = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -e "$HOME/.npm-global" ]; then
      ln -s "$HOME/.local/share/npm-global" "$HOME/.npm-global"
    fi
  '';

  home.sessionPath = [
    "$HOME/.local/share/npm-global/bin"
    "$HOME/.npm-global/bin"
    "$HOME/Dev/go/bin"
  ];
}
