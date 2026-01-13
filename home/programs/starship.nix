{ ... }:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;

      format = "$directory$git_branch$git_status$character";

      directory = {
        style = "bold blue";
        truncate_to_repo = true;
        truncation_length = 3;
        fish_style_pwd_dir_length = 1; # '~/w/p/my-project'
      };

      character = {
        success_symbol = "[󰄾](bold green)";
        error_symbol = "[󰄾](bold red)";
        vicmd_symbol = "[󰄾](bold yellow)";
      };

      git_branch = {
        symbol = "󰊢 ";
        format = "on [$symbol$branch]($style) ";
        style = "bold white";
      };

      git_status = {
        format = "([\\[$all_status$ahead_behind\\]]($style) )";
        style = "red";
      };

      package.disabled = true;
      python.disabled = true;
      nodejs.disabled = true;
      lua.disabled = true;
    };
  };
}
