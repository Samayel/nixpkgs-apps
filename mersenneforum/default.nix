{ nixpkgs ? import <nixpkgs> { config = import ./config.nix; } }:

let
  allPkgs = nixpkgs // pkgs;

  callPackage = path: overrides:
    let f = import path;
    in f ((builtins.intersectAttrs (builtins.functionArgs f) allPkgs) // overrides);

  pkgs = rec {
    ecmgit = callPackage ./packages/ecmgit.nix { };
    yafu = callPackage ./packages/yafu.nix { ecm = ecmgit; };
  };
in

allPkgs
