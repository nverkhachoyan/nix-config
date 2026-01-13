{ ... }:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      # Move the prompt to a single line for a tighter feel
      add_newline = false;

      # The prompt layout: keep it simple
      format = "$directory$git_branch$git_status$character";

      # Clean up the directory look
      directory = {
        style = "bold blue";
        truncate_to_repo = true; # Focus on the project root
        truncation_length = 3;
        fish_style_pwd_dir_length = 1; # '~/w/p/my-project'
      };

      # Subtle Character (the prompt symbol)
      character = {
        success_symbol = "[󰄾](bold green)";
        error_symbol = "[󰄾](bold red)";
        vicmd_symbol = "[󰄾](bold yellow)";
      };

      # Minimal Git
      git_branch = {
        symbol = "󰊢 ";
        format = "on [$symbol$branch]($style) ";
        style = "bold white";
      };

      git_status = {
        format = "([\\[$all_status$ahead_behind\\]]($style) )";
        style = "red";
      };

      # Disable things that add clutter
      package.disabled = true;
      python.disabled = true;
      nodejs.disabled = true;
      lua.disabled = true;
    };
  };
}
