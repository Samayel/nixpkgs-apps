{ lib, stdenv, fetchsvn, subversion, zlib, gmp, ecm }:

let
  pname = "msieve";
  version = "svn-1044";
  name = "${pname}-${version}";
in

stdenv.mkDerivation rec {
  inherit name;

  src = fetchsvn {
    url = "https://svn.code.sf.net/p/msieve/code/trunk/";
    rev = "1044";
    sha256 = "njutwl3z09yK4oahFYHpLrKGpVSoJqUxFeuou4zeQWU=";
  };

  buildInputs = [ subversion zlib gmp ecm ];

  ECM = if ecm == null then "0" else "1";

  # Doesn't hurt Linux but lets clang-based platforms like Darwin work fine too
  makeFlags = [ "CC=${stdenv.cc.targetPrefix}cc" "all" ];

  installPhase = ''
    mkdir -p $out/bin/
    cp msieve $out/bin/
  '';

  meta = {
    description = "A C library implementing a suite of algorithms to factor large integers";
    license = lib.licenses.publicDomain;
    homepage = "http://msieve.sourceforge.net/";
    platforms = [ "x86_64-linux" ] ++ lib.platforms.darwin;
  };
}
