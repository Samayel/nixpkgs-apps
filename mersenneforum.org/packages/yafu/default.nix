{ stdenv, fetchgit, gmp, ecm, msieve, ytools, ysieve, ggnfs }:

let
  name = "${pname}-${version}";
  pname = "yafu";
  version = "git-" + builtins.substring 0 8 commit;
  commit = "ca48c65b66a465a5a47cf7da0301f4ef56227573";
in

stdenv.mkDerivation {
  inherit name;

  src = fetchgit {
    url = "https://github.com/bbuhrow/yafu";
    rev = commit;
    sha256 = "ZBYBzIxOiGb+5CRxpF2ubt2goEtvaDIUyutK5fMk7EU=";
  };

  buildInputs = [ gmp ecm msieve ytools ysieve ggnfs ];

  patchPhase = ''
    runHook prePatch

    sed -i -e 's| /users/buhrow/src/c/gmp_install/gmp-6.2.0/lib/libgmp.a | -lgmp |g' Makefile

    runHook postPatch
  '';

  makeFlags = [ "COMPILER=gcc" "NFS=1" "USE_SSE41=1" "USE_AVX2=1" "USE_BMI2=1" ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp yafu $out/bin/

    runHook postInstall
  '';
}
