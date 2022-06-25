{ sources ? import ./nix/sources.nix
, nixpkgs ? import sources.nixpkgs { overlays = [] ; config = import ./config.nix; }
}:

nixpkgs
