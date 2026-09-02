{ lib, rustPlatform, fetchFromGitHub, pkg-config, makeWrapper
, alsa-lib, libpulseaudio, libxkbcommon, wayland, libGL, xorg }:

rustPlatform.buildRustPackage rec {
  pname = "fastpotify";
  version = "0.4.1";

  src = fetchFromGitHub {
    owner = "crmne";
    repo = "fastpotify";
    rev = "v0.4.1";
    hash = "sha256-z/g5T2qR7nyBbxeSDEJ8GVRkyrkX/6F6GOLUa7lvgMM=";
  };

  # Committed upstream; no git deps, so no vendorHash/outputHashes needed.
  cargoLock.lockFile = "${src}/Cargo.lock";

  nativeBuildInputs = [ pkg-config makeWrapper ];
  buildInputs = [ alsa-lib libpulseaudio ];

  # The GUI (egui/winit/glutin) dlopens its Wayland/X11/GL libraries at
  # runtime, so they must be on LD_LIBRARY_PATH or the app dies at launch.
  postFixup = ''
    wrapProgram $out/bin/fastpotify \
      --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [
        libxkbcommon wayland libGL xorg.libX11 xorg.libXcursor
        xorg.libXi xorg.libXrandr
      ]}
  '';

  postInstall = ''
    install -Dm644 $src/packaging/applications/fastpotify.desktop \
      $out/share/applications/fastpotify.desktop
    install -Dm644 $src/packaging/icons/fastpotify.svg \
      $out/share/icons/hicolor/scalable/apps/fastpotify.svg
  '';

  meta = with lib; {
    description = "Fast native Spotify client with local playback and Spotify Connect";
    homepage = "https://fastpotify.rocks";
    license = licenses.mit;
    mainProgram = "fastpotify";
    platforms = platforms.linux;
  };
}
