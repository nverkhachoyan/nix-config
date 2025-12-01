{ ... }:

{
  programs.sketchybar = {
    enable = true;

    config = ''
      # Basic bar
      bar=(
        position  top
        height    32
        padding_left 10
        padding_right 10
      )
      sketchybar --bar "$bar"

      # Add spaces indicator
      sketchybar --add item spaces left
      sketchybar --set spaces script="$PLUGIN_DIR/spaces.sh"

      # Add clock
      sketchybar --add item time right
      sketchybar --set time script="$PLUGIN_DIR/time.sh" update_freq=10
    '';
  };

  # Plugin scripts placed in ~/.config/sketchybar/plugins/
  xdg.configFile."sketchybar/plugins/spaces.sh".text = ''
    #!/usr/bin/env bash
    CURRENT=$(osascript -e 'tell application "System Events" to get the index of the current desktop')
    sketchybar --set "$NAME" label="$CURRENT"
  '';

  xdg.configFile."sketchybar/plugins/time.sh".text = ''
    #!/usr/bin/env bash
    sketchybar --set "$NAME" label="$(date '+%H:%M')"
  '';
}
