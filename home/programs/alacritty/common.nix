{ ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = 12.0;
        normal = {
          family = "DroidSansM Nerd Font";
        };
      };

      window = {
        decorations = "None";
        padding = {
          x = 12;
          y = 12;
        };
        opacity = 1.0;
        dynamic_title = true;
        dynamic_padding = true;
        startup_mode = "Maximized";
      };

      colors = {
        primary = {
          background = "#101418";
          foreground = "#e0e2e8";
        };

        selection = {
          text = "#e0e2e8";
          background = "#124a73";
        };

        cursor = {
          text = "#101418";
          cursor = "#9dcbfb";
        };

        normal = {
          black = "#101418";
          red = "#d75a59";
          green = "#8ed88c";
          yellow = "#e0d99d";
          blue = "#4087bc";
          magenta = "#839fbc";
          cyan = "#9dcbfb";
          white = "#abb2bf";
        };

        bright = {
          black = "#5c6370";
          red = "#e57e7e";
          green = "#a2e5a0";
          yellow = "#efe9b3";
          blue = "#a7d9ff";
          magenta = "#3d8197";
          cyan = "#5c7ba3";
          white = "#ffffff";
        };
      };

      cursor = {
        style = {
          shape = "Block";
          blinking = "On";
        };
        blink_interval = 500;
        unfocused_hollow = true;
      };

      mouse = {
        hide_when_typing = true;
      };

      selection = {
        save_to_clipboard = false;
      };

      bell = {
        duration = 0;
      };

      keyboard = {
        bindings = [
          {
            key = "C";
            mods = "Control|Shift";
            action = "Copy";
          }
          {
            key = "V";
            mods = "Control|Shift";
            action = "Paste";
          }
          {
            key = "N";
            mods = "Control|Shift";
            action = "SpawnNewInstance";
          }
          {
            key = "Equals";
            mods = "Control|Shift";
            action = "IncreaseFontSize";
          }
          {
            key = "Minus";
            mods = "Control";
            action = "DecreaseFontSize";
          }
          {
            key = "Key0";
            mods = "Control";
            action = "ResetFontSize";
          }
          {
            key = "Enter";
            mods = "Shift";
            chars = "\n";
          }
        ];
      };

      terminal = {
        osc52 = "CopyPaste";
      };

      scrolling = {
        history = 3023;
        multiplier = 3;
      };
    };
  };
}
