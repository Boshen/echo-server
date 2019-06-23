{ mkDerivation, aeson, base, bytestring, case-insensitive, hspec
, hspec-wai, http-types, scotty, stdenv, text, wai, wai-extra
}:
mkDerivation {
  pname = "echo-server";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [ base ];
  executableHaskellDepends = [ aeson base scotty text ];
  testHaskellDepends = [
    aeson base bytestring case-insensitive hspec hspec-wai http-types
    scotty text wai wai-extra
  ];
  doHaddock = false;
  license = "unknown";
  hydraPlatforms = stdenv.lib.platforms.none;
}
