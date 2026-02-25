{
  pkgs,
  username,
  host,
  ...
}:
{
  networking.hostName = host.name;
  networking.computerName = host.name;

  users.users."${username}" = {
    home = host.homeDirectory;
  };

  environment.systemPackages = with pkgs; [
    git
    wget
    google-chrome
    monitorcontrol
  ];
}
