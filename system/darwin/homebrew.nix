{ ... }:
{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
    taps = [ "localstack/tap" ];

    brews = [
      "localstack"
    ];
    casks = [
      "ghostty"
      "alacritty"
      "1password"
      "1password-cli"
      "orbstack"
    ];
  };
}
