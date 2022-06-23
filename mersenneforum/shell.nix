{ nixpkgs ? import <nixpkgs> { config = import ./config.nix; } }:

let
  pkgs = import ./default.nix { inherit nixpkgs; };

  params = with pkgs; {
    buildInputs = [ yafu ];
  };
in

pkgs.runCommand "dummy" params ""
