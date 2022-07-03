{ pkgs }:

pkgs.mkShell {
  buildInputs = [ pkgs.hello-flake.hello ];

  NIXSHELL_GREETING = "Hello, shell!";

  shellHook =
  ''
    echo $NIXSHELL_GREETING
  '';
}
