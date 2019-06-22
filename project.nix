{ mkDerivation, base, hspec, hspec-wai, hspec-wai-json, scotty
, stdenv
}:
mkDerivation {
  pname = "echo-server";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [ base ];
  executableHaskellDepends = [ base scotty ];
  testHaskellDepends = [ base hspec hspec-wai hspec-wai-json ];
  doHaddock = false;
  license = stdenv.lib.licenses.bsd3;
}
