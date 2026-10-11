{ config, lib, pkgs, ... }:

let
  colors = config.lib.stylix.colors.withHashtag;
in
{
  programs = {
    nixcord = {
      enable = true;

      discord = {
        enable = false;
      };

      vesktop = {
        enable = true;
      };

      config = {
        # Filename must match the theme file in ~/.config/vesktop/themes exactly.
        enabledThemes = lib.mkForce [ "vague.theme.css" ];
        plugins = {
          gifPaste = {
            enable = true;
          };

          fakeNitro = {
            enable = true;
          };

          fixCodeblockGap = {
            enable = true;
          };

          fixYoutubeEmbeds = {
            enable = true;
          };

          youtubeAdblock = {
            enable = true;
          };
        };

        useQuickCss = true;
        disableMinSize = true;
      };
    };

    yt-dlp.enable = true;

    mpv = {
      enable = true;

      config = {
        background = "color";
        background-color = lib.mkDefault colors.base00;
      };
    };

    imv = {
      enable = true;

      settings = {
        options = {
          background = colors.base00;
        };
      };
    };

    zathura.enable = true;
  };

  home.packages = with pkgs; [
    spotify
    spicetify-cli
    yazi
    bc
    # Run AppImages on NixOS: supplies libfuse.so.2 + the ELF libs the
    # bundle expects. Usage: appimage-run ./foo.AppImage
    appimage-run
  ];

  # Launcher entry pointing at the spicetify-patched copy
  # (the packaged desktop file execs the read-only store binary).
  home.file.".local/share/applications/spotify.desktop" = {
    text = ''
      [Desktop Entry]
      Name=Spotify
      Comment=Play music with the spicetify-patched client
      Exec=${config.home.homeDirectory}/.local/share/spotify/spotify %U
      Icon=spotify
      Type=Application
      Terminal=false
      Categories=AudioVideo;Audio;Player;
    '';
  };

  # ZCode rewrites this entry on every start, pointing Exec at the raw
  # AppImage. That can't self-mount on NixOS (no libfuse.so.2), so the
  # launcher silently does nothing. ZCode (via appimage-run) manages to
  # replace the store symlink anyway, so force = true reclaims the path
  # on every activation instead of dying on a backup collision.
  home.file.".local/share/applications/zcode.desktop" = {
    force = true;
    text = ''
      [Desktop Entry]
      Name=ZCode
      Comment=ZCode Desktop App
      Exec=${pkgs.appimage-run}/bin/appimage-run ${config.home.homeDirectory}/Downloads/ZCode-3.14.4-linux-x64.AppImage %U
      Icon=zcode
      Type=Application
      Terminal=false
      StartupWMClass=ZCode
      Categories=Development;
      MimeType=x-scheme-handler/zcode;
    '';
  };

  home.file.".local/bin/spicetify-setup.sh" = {
    source = ./files/.local/bin/spicetify-setup.sh;
    executable = true;
  };

  # spicetify writes state into its config dir, so seed a writable copy once.
  home.activation.seedSpicetify = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    if [ ! -e "$HOME/.config/spicetify" ]; then
      mkdir -p "$HOME/.config"
      cp -aL ${./files/.config/spicetify} "$HOME/.config/spicetify"
      chmod -R u+w "$HOME/.config/spicetify"
    fi
  '';

  # yazi + custom "vague" flavor (colors mirror the Zed Vague theme)
  home.file.".config/yazi/theme.toml" = {
    source = ./files/.config/yazi/theme.toml;
  };
  home.file.".config/yazi/flavors/vague.yazi/flavor.toml" = {
    source = ./files/.config/yazi/flavors/vague.yazi/flavor.toml;
  };

  xdg.mimeApps = {
    enable = true;

    defaultApplications = let
      helium = [
        "helium.desktop"
      ];
    in {
      "text/xml" = helium;
      "text/html" = helium;
      "x-scheme-handler/http" = helium;
      "x-scheme-handler/https" = helium;
    };
  };
}
