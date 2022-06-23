{ nixpkgs ? import <nixpkgs> { config = import ./config.nix; } }:

let
  pkgs = with nixpkgs; rec {
    ecmgit = callPackage ./packages/ecmgit.nix { };
    yafu = callPackage ./packages/yafu.nix { };
  };

  allPkgs = nixpkgs // pkgs;
  params = with allPkgs; { buildInputs = [ yafu ]; };
in
  nixpkgs.runCommand "dummy" params ""
