{ ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = 20.0;
        normal = {
          family = "DroidSansM Nerd Font";
        };
      };

      window = {
        dynamic_title = true;
        dynamic_padding = true;
        startup_mode = "Maximized";
        blur = true;
        option_as_alt = "Both";
      };

      colors = {
        primary = {
          background = "#000000";
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
