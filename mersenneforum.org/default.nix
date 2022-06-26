{ sources ? import ./nix/sources.nix
, nixpkgs ? import sources.nixpkgs { overlays = [] ; config = import ./config.nix; }
}:

let
  allPkgs = nixpkgs // pkgs;

  callPackage = path: overrides:
    let f = import path;
    in nixpkgs.lib.makeOverridable f ((builtins.intersectAttrs (builtins.functionArgs f) allPkgs) // overrides);

  pkgs = rec {
    gmp = nixpkgs.gmp;
    ecm-git = callPackage ./packages/ecm-git { };
    msieve-svn = callPackage ./packages/msieve-svn { ecm = ecm-git; zlib = null; };
    ytools = callPackage ./packages/ytools { };
    ysieve = callPackage ./packages/ysieve { };
    yafu = callPackage ./packages/yafu { ecm = ecm-git; msieve = msieve-svn; };
  };
in

allPkgs
