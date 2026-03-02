{ config, pkgs, ... }:
{
  systemd.user.services = {

    swww-daemon = {
      Unit = {
        Description = "swww wallpaper daemon";
        PartOf = [ "hyprland-session.target" ];
        After = [ "hyprland-session.target" ];
        ConditionEnvironment = "WAYLAND_DISPLAY";
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.swww}/bin/swww-daemon";
        Restart = "on-failure";
      };
      Install = {
        WantedBy = [ "hyprland-session.target" ];
      };
    };

    hypr-wallpaper = {
      Unit = {
        Description = "Apply random wallpaper and refresh Hyprland accent theme";
        After = [
          "hyprland-session.target"
          "swww-daemon.service"
          "waybar.service"
        ];
        Wants = [ "swww-daemon.service" ];
        ConditionEnvironment = "WAYLAND_DISPLAY";
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${config.home.homeDirectory}/.config/hypr/scripts/wallpaper-rotate.sh";
      };
    };

    timers.hypr-wallpaper = {
      Unit = {
        Description = "Rotate Hyprland wallpaper every 15 minutes";
      };
      Timer = {
        OnBootSec = "20s";
        OnUnitActiveSec = "15m";
        Persistent = true;
        Unit = "hypr-wallpaper.service";
      };
      Install = {
        WantedBy = [ "timers.target" ];
      };
    };

    hypr-monitor-hotplug = {
      Unit = {
        Description = "Hyprland monitor hotplug handler";
        After = [ "hyprland-session.target" ];
        PartOf = [ "hyprland-session.target" ];
        ConditionEnvironment = "HYPRLAND_INSTANCE_SIGNATURE";
      };
      Service = {
        Type = "simple";
        ExecStart = "${config.home.homeDirectory}/.config/hypr/scripts/monitor-hotplug.sh";
        Restart = "on-failure";
        RestartSec = "1";
      };
      Install = {
        WantedBy = [ "hyprland-session.target" ];
      };
    };

    elephant = {
      Unit = {
        Description = "Elephant";
        After = [ "hyprland-session.target" ];
        PartOf = [ "hyprland-session.target" ];
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.elephant}/bin/elephant";
        Restart = "on-failure";
      };
      Install = {
        WantedBy = [ "hyprland-session.target" ];
      };
    };

    walker-gapplication = {
      Unit = {
        Description = "Walker gapplication service";
        After = [
          "hyprland-session.target"
          "elephant.service"
        ];
        PartOf = [ "hyprland-session.target" ];
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.walker}/bin/walker --gapplication-service";
        Restart = "on-failure";
      };
      Install = {
        WantedBy = [ "hyprland-session.target" ];
      };
    };
  };
}
