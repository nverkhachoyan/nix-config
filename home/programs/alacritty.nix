{ root, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = 20.0;
        normal = {
          family = "DroidSansMono Nerd Font";
        };
      };

      window = {
        decorations = "Buttonless";
        dynamic_title = true;
        dynamic_padding = true;
        startup_mode = "Maximized";
        opacity = 0.7;
        blur = true;
      };

      colors = {
        primary = {
          background = "0x000000";
          foreground = "0xFFFFFF";
        };
        cursor = {
          text = "0x000000";
          cursor = "0xFFFFFF";
        };
        normal = {
          black = "0x000000";
          red = "0xFF5555";
          green = "0x50FA7B";
          yellow = "0xF1FA8C";
          blue = "0xBD93F9";
          magenta = "0xFF79C6";
          cyan = "0x8BE9FD";
          white = "0xBFBFBF";
        };
        bright = {
          black = "0x4D4D4D";
          red = "0xFF6E67";
          green = "0x5AF78E";
          yellow = "0xF4F99D";
          blue = "0xCAA9FA";
          magenta = "0xFF92D0";
          cyan = "0x9AEDFE";
          white = "0xE6E6E6";
        };
      };

      terminal = {
        osc52 = "CopyPaste";
      };

      scrolling = {
        history = 10000;
        multiplier = 3;
      };
    };
  };
}
