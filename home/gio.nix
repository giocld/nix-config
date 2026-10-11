{ username, terminal, helium, fastpotify, magnitude, inputs, ... }:

{
  imports = [
    inputs.nixcord.homeModules.default

    ./shell.nix
    ./wm.nix
    ./editors.nix
    ./apps.nix
    ./pi.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "24.11";

  home.packages = [
    helium
    fastpotify
    magnitude
  ];

  programs = {
    git = {
      enable = true;
      settings.user.email = "georgspiliopouloss@gmail.com";
      settings.user.name = "giocld";
    };

    git-credential-oauth.enable = true;

    lazygit.enable = true;
    gh.enable = true;
  };

  systemd.user.startServices = false;

  services.gnome-keyring.enable = true;

  home.persistence."/pers/home/${username}" = {
    allowOther = true;

    directories = [
      # "document"
      "download"
      "project"

      ".config/xfce4/xfconf"
      ".config/Proton"
      ".config/vesktop"

      # magnitude: CLI releases, inference backends, downloaded models
      ".magnitude"
    ];

    files = [
      ".local/share/zoxide/db.zo"
    ];
  };
}
