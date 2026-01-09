{ ... }:

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
        dynamic_title = true;
        dynamic_padding = true;
        startup_mode = "Maximized";
        opacity = 0.9;
        blur = true;
        option_as_alt = "Both";
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
