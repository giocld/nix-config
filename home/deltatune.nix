{ deltatune, ... }:

{
  systemd.user.services.deltatune = {
    Unit = {
      Description = "DeltaTune now-playing overlay (one instance per monitor)";
      After = [ "default.target" "pipewire.service" ];
      Wants = [ "pipewire.service" ];
    };

    Service = {
      Type = "simple";
      ExecStart = "${deltatune}/bin/deltatune";
      Environment = [
        "DISPLAY=:0"
        "WAYLAND_DISPLAY=wayland-1"
        "XDG_CURRENT_DESKTOP=Hyprland"
      ];
      Restart = "on-failure";
      RestartSec = 3;
    };

    Install.WantedBy = [ "default.target" ];
  };
}
