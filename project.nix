{ mkDerivation, base, hspec, stdenv }:
mkDerivation {
  pname = "echo-server";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [ base ];
  executableHaskellDepends = [ base ];
  testHaskellDepends = [ base hspec ];
  doHaddock = false;
  license = stdenv.lib.licenses.bsd3;
}
