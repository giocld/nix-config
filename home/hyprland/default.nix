{config, pkgs, ...}: let
  xremapConfig = (pkgs.formats.yaml {}).generate "xremap-config.yml" config.services.xremap.config;
in {
  imports = [
    ./input.nix
    ./layout.nix
  ];

  home.packages = [
    pkgs.hyprpaper
    pkgs.hyprpicker
    pkgs.swayidle
    pkgs.xremap
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    package = null;
    portalPackage = null;

    systemd = {
      enable = false;
      variables = [];
    };

    settings = {
      exec-once = [
        "waybar"
        "hyprpaper"
        "dunst"
        "swayidle -w timeout 300 'swaylock -fu' before-sleep 'swaylock -fu' lock 'swaylock -fu'"
        "swayosd-server --style ${../swayosd/style.css}"
        "wl-paste --watch cliphist -max-dedupe-search 10 -max-items 500 store"
        "wl-paste --type image --watch cliphist -max-dedupe-search 10 -max-items 500 store"
        "xremap ${xremapConfig}"
      ];

      general = {
        border_size = 6;

        gaps_in = 0;
        gaps_out = 0;

        layout = "dwindle";
      };

      decoration = {
        shadow = {
          enabled = false;
        };
      };

      dwindle = {
        preserve_split = true;
        smart_split = true;
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      monitor = ",preferred,auto,1.6";

      xwayland = {
        force_zero_scaling = true;
      };
    };
  };

  services.xremap = {
    withHypr = true;
  };
}
