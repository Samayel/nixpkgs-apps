{ stdenv }:

let
  name = "${pname}-${version}";
  pname = "ytools";
  version = "git-" + builtins.substring 0 8 commit;
  commit = "bf7f82d05ec9b74b3b1c0b99a734c321d7eb540c";
in

stdenv.mkDerivation {
  inherit name;

  src = fetchGit {
    url = "https://github.com/bbuhrow/ytools";
    rev = commit;
    ref = "main";
  };

  makeFlags = [ "COMPILER=gcc" "USE_AVX2=1" ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/{include,lib}
    cp ytools.h $out/include/
    cp threadpool.h $out/include/
    cp libytools.a $out/lib/

    runHook postInstall
  '';
}
