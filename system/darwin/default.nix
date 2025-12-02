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
  imports = [
    ./nix.nix
    ./homebrew.nix
    ./system.nix
  ];

  users.users."${username}" = {
    home = "/Users/${username}";
  };

  environment.systemPackages = with pkgs; [
    git
    wget
  ];

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.droid-sans-mono
  ];

  security.pam.services.sudo_local.touchIdAuth = true;

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";
  home-manager.extraSpecialArgs = {
    inherit username root;
  };

  home-manager.users.${username} = {
    imports = [
      ../../home/home.nix
    ];
  };
}
