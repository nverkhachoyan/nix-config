{
  root,
  nixpkgs,
  home-manager,
  darwin,
  config,
  pkgs,
  username,
  ...
}:

{
  system = {
    primaryUser = username;
    stateVersion = 6;
  };

  users.users."${username}" = {
    home = "/Users/${username}";
  };

  environment.systemPackages = with pkgs; [
    git
    wget
  ];

  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.droid-sans-mono
  ];

  security.pam.services.sudo_local.touchIdAuth = true;
  system.defaults.dock.autohide = true;

  nix.settings = {
    trusted-users = [
      "root"
      "${username}"
    ];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  nix.optimise.automatic = true;

  nix.registry = {
    self.flake = root;
    nixpkgs.flake = nixpkgs;
    home-manager.flake = home-manager;
    darwin.flake = darwin;
  };

  nix.nixPath = [
    "nixpkgs=${nixpkgs.outPath}"
    "home-manager=${home-manager.outPath}"
    "darwin=${darwin.outPath}"
    "self=${root.outPath}"
  ];

  nix.gc = {
    automatic = true;
    interval = {
      Weekday = 0;
      Hour = 2;
      Minute = 0;
    };
    options = "--delete-older-than 7d";
  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
    taps = [ ];
    brews = [ ];
    casks = [
      "ghostty"
      "alacritty"
    ];
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";
  home-manager.extraSpecialArgs = {
    inherit username root;
  };

  home-manager.users.${username} = {
    imports = [
      ../home/home.nix
    ];
  };
}
