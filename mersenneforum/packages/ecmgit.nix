{ lib, stdenv, fetchurl, autoreconfHook, gmp, m4 }:

let
  pname = "ecm";
  version = "git-5663e00c";
  name = "${pname}-${version}";
in

stdenv.mkDerivation {
  inherit name;

  src = fetchGit {
    url = "https://gitlab.inria.fr/zimmerma/ecm";
    rev = "5663e00cb4880a6ee6393eb9067e9eea201098d4";
  };

  nativeBuildInputs = [
    autoreconfHook
  ];

  # See https://trac.sagemath.org/ticket/19233
  configureFlags = lib.optional stdenv.isDarwin "--disable-asm-redc";

  buildInputs = [ m4 gmp ];

  doCheck = true;
  preCheck = "sed -i -e 's|^/bin/rm |rm |g' test.*";

  meta = {
    description = "Elliptic Curve Method for Integer Factorization";
    license = lib.licenses.gpl2Plus;
    homepage = "http://ecm.gforge.inria.fr/";
    platforms = with lib.platforms; linux ++ darwin;
  };
}
