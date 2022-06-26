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
    ];

#   NIXSHELL_GREETING = "Hello, shell!";
#
#   shellHook =
#   ''
#       echo $NIXSHELL_GREETING
#   '';

}
