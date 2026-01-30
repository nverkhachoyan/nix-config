{ username, ... }:
{
  system = {
    primaryUser = username;
    stateVersion = 6;
    defaults = {
      menuExtraClock = {
        ShowDate = 0;
      };

      controlcenter = {
        FocusModes = false;
      };

      dock = {
        show-recents = false;
        mru-spaces = false;
        # This clears all pinned apps from the Dock
        persistent-apps = [];
        tilesize = 38;
      };

      finder = {
        QuitMenuItem = true;
        ShowPathbar = true;
        ShowStatusBar = true;
        NewWindowTarget = "Home";
        FXPreferredViewStyle = "clmv";
      };


      NSGlobalDomain = {
        KeyRepeat = 2;
        # Disables various autocorrect features
        NSAutomaticSpellingCorrectionEnabled = false;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
      };

      WindowManager = {
        EnableTiledWindowMargins = false;
        EnableStandardClickToShowDesktop = false;
      };

      screencapture.location = "~/Documents/Media/Screenshots";

    };

      keyboard.enableKeyMapping = true;
      keyboard.remapCapsLockToControl = true;
    
 
  };
}
