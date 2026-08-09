{...}: {
  systemd.user.units = {
    "cliphist.service".restartIfChanged = false;
    "cliphist-images.service".restartIfChanged = false;
    "dunst.service".restartIfChanged = false;
    "hyprpaper.service".restartIfChanged = false;
    "swayidle.service".restartIfChanged = false;
    "swayosd.service".restartIfChanged = false;
    "xremap.service".restartIfChanged = false;
    "graphical-session.target".restartIfChanged = false;
    "hyprland-session.target".restartIfChanged = false;
    "tray.target".restartIfChanged = false;
  };
}
