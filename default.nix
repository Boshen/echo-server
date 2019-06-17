{ pkgs ? import <nixpkgs> { } }:
let
  project = pkgs.haskellPackages.callPackage ./project.nix { };
in pkgs.mkShell {
  buildInputs = [ pkgs.haskellPackages.ghcid ];
  inputsFrom = [ project.env ];
}
