{
  inputs,
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
    raycast
  ];

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    HOMEBREW_NO_ENV_HINTS = "1";
  };

  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.droid-sans-mono
  ];

  security.pam.services.sudo_local.touchIdAuth = true;

  home-manager = {

    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = {
      inherit inputs username;
    };

    users.${username} = {
      imports = [
        inputs.nixvim.homeModules.nixvim
        ../../home/home.nix
      ];
    };
  };

}
