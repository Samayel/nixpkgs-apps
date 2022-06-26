{ stdenv, gmp, ecm, msieve, ytools, ysieve }:

let
  name = "${pname}-${version}";
  pname = "yafu";
  version = "git-" + builtins.substring 0 8 commit;
  commit = "ca48c65b66a465a5a47cf7da0301f4ef56227573";
in

stdenv.mkDerivation {
  inherit name;

  src = fetchGit {
    url = "https://github.com/bbuhrow/yafu";
    rev = commit;
  };

  buildInputs = [ gmp ecm msieve ytools ysieve ];

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
