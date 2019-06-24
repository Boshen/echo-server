{ mkDerivation, aeson, base, bytestring, case-insensitive, hspec
, hspec-wai, http-types, scotty, stdenv, text, wai, wai-extra
}:
mkDerivation {
  pname = "echo-server";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [ aeson base http-types scotty text ];
  executableHaskellDepends = [ aeson base http-types scotty text ];
  testHaskellDepends = [
    aeson base bytestring case-insensitive hspec hspec-wai http-types
    scotty text wai wai-extra
  ];
  license = "unknown";
  hydraPlatforms = stdenv.lib.platforms.none;
}
