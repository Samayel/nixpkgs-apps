{ stdenv, fetchgit, gmp, ecm, msieve, ytools, ysieve, ggnfs, bash }:

let
  name = "${pname}-${version}";
  pname = "yafu";
  version = "git-" + builtins.substring 0 8 commit;
  commit = "ca48c65b66a465a5a47cf7da0301f4ef56227573";
in

assert gmp == ecm.gmp;
assert gmp == msieve.gmp;
assert gmp == ysieve.gmp;
assert gmp == ggnfs.gmp;
assert ecm == msieve.ecm;
assert ytools == ysieve.ytools;
assert null == msieve.zlib;

stdenv.mkDerivation {
  inherit name gmp ecm msieve ytools ysieve ggnfs;

  src = fetchgit {
    url = "https://github.com/bbuhrow/yafu";
    rev = commit;
    sha256 = "ZBYBzIxOiGb+5CRxpF2ubt2goEtvaDIUyutK5fMk7EU=";
  };

  buildInputs = [ gmp ecm msieve ytools ysieve ggnfs bash ];

  patchPhase = ''
    runHook prePatch

    sed -i -e 's| /users/buhrow/src/c/gmp_install/gmp-6.2.0/lib/libgmp.a | -lgmp |g' Makefile

    runHook postPatch
  '';

  makeFlags = [ "COMPILER=gcc" "NFS=1" "USE_SSE41=1" "USE_AVX2=1" "USE_BMI2=1" ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp yafu $out/bin/yafu-wrapped

    cp yafu.ini $out/bin/
    sed -i -e "s|^% threads=1$|threads=4|"                  $out/bin/yafu.ini
    sed -i -e "s|^% nprp=1$|nprp=20|"                       $out/bin/yafu.ini
    sed -i -e "s|^v$|% v|"                                  $out/bin/yafu.ini
    sed -i -e "s|^ggnfs_dir=.*$|ggnfs_dir=${ggnfs}/bin/|"   $out/bin/yafu.ini
    sed -i -e "s|^ecm_path=.*$|ecm_path=${ecm}/bin/ecm|"    $out/bin/yafu.ini
    sed -i -e "s|^ext_ecm=.*$|ext_ecm=10000|"               $out/bin/yafu.ini

    cat > $out/bin/yafu <<'EOF'
    #!${bash}/bin/bash
    WORKDIR=$(mktemp -d)
    pushd $WORKDIR
    cp /out/bin/yafu-wrapped ./yafu
    cp /out/bin/yafu.ini .
    chmod +w ./*
    ./yafu "$@"
    popd
    rm -rfI $WORKDIR
    EOF

    sed -i -e "s|/out/|$out/|g" $out/bin/yafu
    chmod +x $out/bin/yafu

    runHook postInstall
  '';
}
