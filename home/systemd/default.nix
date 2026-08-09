{...}: {
  systemd.user.services = {
    cliphist.restartIfChanged = false;
    "cliphist-images".restartIfChanged = false;
    dunst.restartIfChanged = false;
    hyprpaper.restartIfChanged = false;
    swayidle.restartIfChanged = false;
    swayosd.restartIfChanged = false;
    xremap.restartIfChanged = false;
  };

  systemd.user.targets = {
    graphical-session.restartIfChanged = false;
    hyprland-session.restartIfChanged = false;
    tray.restartIfChanged = false;
  };
}
