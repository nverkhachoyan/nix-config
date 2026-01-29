{ username, ... }:
{
  system = {
    primaryUser = username;
    stateVersion = 6;
    defaults = {
      dock = {
        show-recents = false;
        mru-spaces = false;
        # This clears all pinned apps from the Dock
        persistent-apps = [];
      };

      finder = {
        ShowPathbar = true;
        ShowStatusBar = true;
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
    };
  };
}