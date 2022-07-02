{ sources ? import ./nix/sources.nix
, nixpkgs ? import sources.nixpkgs { overlays = [] ; config = import ./config.nix; }
}:

let
  pkgs = import ./default.nix { inherit nixpkgs; };
in

pkgs.mkShell {

    nativeBuildInputs = with pkgs; [
        niv
        ecm-git
        msieve-svn
        ysieve
        yafu
        ggnfs
        ecmpy
        factmsievepy
        aliqueit
        cado-nfs
        primesieve
        primecount
        primesum
    ];

#   NIXSHELL_GREETING = "Hello, shell!";
#
#   shellHook =
#   ''
#       echo $NIXSHELL_GREETING
#   '';

}
