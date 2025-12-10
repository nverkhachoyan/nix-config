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
    ];
  };
}
