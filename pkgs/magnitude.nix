{ lib, stdenv, fetchurl, nodejs, makeWrapper }:

stdenv.mkDerivation (finalAttrs: {
  pname = "magnitude";
  version = "0.0.11";

  src = fetchurl {
      url = "https://registry.npmjs.org/@magnitudedev/cli/-/cli-${finalAttrs.version}.tgz";
      hash = "sha512-iTCQQ/dBboQBf0V1X/nnx0jLmxv2dKElAN6vNgL1lRVVHPhhGeZQC0WO4u2ByuCjKCIvGvyiqU69+5UVZZg/Sw==";
    };

  # npm tarballs unpack to a top-level `package/` directory.
  sourceRoot = "package";

  dontBuild = true;

  nativeBuildInputs = [ makeWrapper ];

  # The launcher reads its own version from the package.json next to the
  # script (dirname(dirname(entrypoint))), so the npm layout must be kept.
  installPhase = ''
    mkdir -p $out/lib/node_modules/@magnitudedev/cli/bin
    cp -r bin package.json README.md $out/lib/node_modules/@magnitudedev/cli/
    makeWrapper ${nodejs}/bin/node $out/bin/magnitude \
      --add-flags "$out/lib/node_modules/@magnitudedev/cli/bin/magnitude.js"
  '';

  meta = {
    description = "Run your coding agent on local models. Free, private, and offline";
    homepage = "https://magnitude.dev";
    license = lib.licenses.asl20;
    mainProgram = "magnitude";
  };
})