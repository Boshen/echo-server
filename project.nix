{ mkDerivation, aeson, base, bytestring, case-insensitive
, foundation, hpack, hspec, hspec-discover, hspec-wai, http-types
, scotty, stdenv, text, wai, wai-extra
}:
mkDerivation {
  pname = "echo-server";
  version = "0.0.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    aeson base case-insensitive foundation http-types scotty text
  ];
  libraryToolDepends = [ hpack ];
  executableHaskellDepends = [
    aeson base case-insensitive foundation http-types scotty text
  ];
  testHaskellDepends = [
    aeson base bytestring case-insensitive foundation hspec hspec-wai
    http-types scotty text wai wai-extra
  ];
  testToolDepends = [ hspec-discover ];
  preConfigure = "hpack";
  license = stdenv.lib.licenses.bsd3;
}
