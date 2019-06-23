{ mkDerivation, base, hspec, hspec-wai, scotty, stdenv }:
mkDerivation {
  pname = "echo-server";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [ base scotty ];
  executableHaskellDepends = [ base scotty ];
  testHaskellDepends = [ base hspec hspec-wai ];
  doHaddock = false;
  license = "unknown";
  hydraPlatforms = stdenv.lib.platforms.none;
}
