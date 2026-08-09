{lib, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
    timeout = 0;
  };

  console.keyMap = lib.mkForce "us";

  networking.hostName = "nixos";

  time.timeZone = "Europe/Athens";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  boot.kernelParams = [
    "amdgpu.dcdebugmask=0x10"
  ];

  hardware.graphics.enable = true;

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  my.sopsPassword = false;

  users.users.gio = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    initialPassword = "changeme";
  };

  environment.persistence = lib.mkForce {};

  home-manager.users.gio.home.persistence = lib.mkForce {};

  programs.nh.flake = lib.mkForce "/home/gio/configs/schphe";

  environment.sessionVariables.GDK_SCALE = lib.mkForce "1";

  home-manager.users.gio.wayland.windowManager.hyprland.settings.monitor =
    lib.mkForce [
      "DP-2,preferred,auto,1"
      "DP-3,preferred,auto,1"
    ];

  home-manager.users.gio.wayland.windowManager.hyprland.settings.workspace = [
    "1,monitor:DP-2"
    "2,monitor:DP-2"
    "3,monitor:DP-2"
    "4,monitor:DP-2"
    "5,monitor:DP-2"
    "6,monitor:DP-3"
    "7,monitor:DP-3"
    "8,monitor:DP-3"
    "9,monitor:DP-3"
    "10,monitor:DP-3"
  ];

  home-manager.users.gio.wayland.windowManager.hyprland.settings.decoration =
    lib.mkForce {
      rounding = 8;

      active_opacity = 0.87;
      inactive_opacity = 0.80;

      shadow = {
        enabled = false;
      };

      blur = {
        enabled = true;
        size = 6;
        passes = 2;
        vibrancy = 0.2;
      };
    };

  system.stateVersion = "24.11";
}
