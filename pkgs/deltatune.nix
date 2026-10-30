{ lib, stdenv, dotnetCorePackages, SDL2, openal, libGL, libx11, libxext, libxfixes, libxrandr }:
let
  libs = lib.makeLibraryPath [
    SDL2
    openal
    libGL
    libx11
    libxext
    libxfixes
    libxrandr
  ];
in
stdenv.mkDerivation {
  pname = "deltatune";
  version = "1.2.2";

  src = ./deltatune;

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin $out/lib/deltatune $out/share/deltatune
    cp -r . $out/lib/deltatune
    # Settings.json lives in a writable copy, so keep the default out of lib/
    # and install it there only when the user has no settings yet.
    install -m644 Settings.json $out/share/deltatune/Settings.json
    rm $out/lib/deltatune/Settings.json

    cat > $out/bin/deltatune <<'EOF'
    #!/bin/sh
    set -eu
    store="${placeholder "out"}/lib/deltatune"
    runtime="''${XDG_DATA_HOME:-$HOME/.local/share}/deltatune"
    stamp="$runtime/.store-path"

    # The app reads/writes Settings.json next to the DLL, which cannot happen in
    # the read-only store. Run from a writable copy refreshed on every upgrade.
    if [ "$(cat "$stamp" 2>/dev/null)" != "$store" ]; then
      mkdir -p "$runtime"
      cp -r --no-preserve=mode "$store"/. "$runtime"/
      echo "$store" > "$stamp"
    fi

    [ -e "$runtime/Settings.json" ] || install -m644 "${placeholder "out"}/share/deltatune/Settings.json" "$runtime/Settings.json"

    export LD_LIBRARY_PATH="${libs}''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
    exec ${dotnetCorePackages.runtime_8_0}/bin/dotnet "$runtime/DeltaTune.dll" --all-screens "$@"
    EOF
    chmod +x $out/bin/deltatune
    runHook postInstall
  '';

  meta = with lib; {
    description = "DELTARUNE-style now-playing overlay (one instance per monitor)";
    homepage = "https://github.com/Toastworth/DeltaTune";
    license = licenses.mit;
    platforms = [ "x86_64-linux" ];
    mainProgram = "deltatune";
  };
}
