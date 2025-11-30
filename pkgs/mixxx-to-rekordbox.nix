{ lib
, stdenv
, python3
, fetchFromGitHub
, ffmpeg
, makeWrapper
}:

let
  pythonEnv = python3.withPackages (ps: with ps; [
    eyeD3
    lxml
    protobuf
    pydub
    tinytag
    tqdm
  ]);
in
stdenv.mkDerivation rec {
  pname = "mixxx-to-rekordbox";
  version = "0.1.0-unstable-2025-10-28";

  src = fetchFromGitHub {
    owner = "TheKantankerus";
    repo = "MixxxToRekordbox";
    rev = "1dbc393e72ede9a6a39e286362ec88de05254f56";
    hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib/mixxx-to-rekordbox $out/bin
    cp -r . $out/lib/mixxx-to-rekordbox/

    makeWrapper ${pythonEnv}/bin/python $out/bin/mixxx-to-rekordbox \
      --add-flags "$out/lib/mixxx-to-rekordbox/main.py" \
      --prefix PATH : ${lib.makeBinPath [ ffmpeg ]}

    runHook postInstall
  '';

  meta = {
    description = "Sync your Mixxx Playlists to Rekordbox XML, optionally reformatting your files";
    homepage = "https://github.com/TheKantankerus/MixxxToRekordbox";
    license = lib.licenses.gpl3Only;
    maintainers = [ lib.maintainers.bendlas ];
    mainProgram = "mixxx-to-rekordbox";
    platforms = lib.platforms.all;
  };
}
