{ pkgs }:

pkgs.stdenvNoCC.mkDerivation {
  pname = "ollama";
  version = "0.35.0";

  src = pkgs.fetchurl {
    url = "https://github.com/ollama/ollama/releases/download/v0.35.0/ollama-darwin.tgz";
    hash = "sha256-JgjbsKDwE2oZjbnUi0907OVfRSMUo5RS/KNbfPIMJYk=";
  };

  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/bin" "$out/lib/ollama"
    tar -xzf "$src" -C "$out/lib/ollama"
    mv "$out/lib/ollama/ollama" "$out/bin/ollama"

    runHook postInstall
  '';

  meta = {
    description = "Run large language models locally";
    homepage = "https://ollama.com";
    mainProgram = "ollama";
    platforms = pkgs.lib.platforms.darwin;
  };
}
