{ username, ... }:
{
  system = {
    primaryUser = username;
    stateVersion = 6;
    defaults = {
      dock.show-recents = false;
      dock.mru-spaces = false;
      finder.ShowPathbar = true;
      finder.ShowStatusBar = true;

      NSGlobalDomain.KeyRepeat = 2;
    };
  };
}
