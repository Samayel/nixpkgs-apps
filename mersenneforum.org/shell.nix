{ nixpkgs ? import <nixpkgs> { config = import ./config.nix; } }:

let
  pkgs = import ./default.nix { inherit nixpkgs; };

  params = with pkgs; {
    buildInputs = [ ecm-git msieve-svn yafu ];
  };
in

pkgs.runCommand "dummy" params ""
