{
  inputs,
  username,
  host,
  ...
}:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = {
      inherit inputs username host;
      homeDirectory = host.homeDirectory;
    };

    users.${username} = {
      imports = [
        inputs.nixvim.homeModules.nixvim
        ../../home
      ];
    };
  };
}
