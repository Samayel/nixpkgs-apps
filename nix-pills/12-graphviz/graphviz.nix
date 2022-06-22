{ mkDerivation, lib, gdSupport ? true, gd, pkg-config }:

mkDerivation {
  name = "graphviz";
  src = builtins.fetchurl {
    url = "https://gitlab.com/api/v4/projects/4207231/packages/generic/graphviz-releases/2.49.3/graphviz-2.49.3.tar.gz";
    sha256 = "f79b203ddc98e0f994d218acd6cb490b962003be7145f7e31de05b6ab0e2ccbf";
  };
  buildInputs =
    if gdSupport
      then [
          pkg-config
          (lib.getLib gd)
          (lib.getDev gd)
        ]
      else [];
}
