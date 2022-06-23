{
  packageOverrides = pkgs: {
    gmp = pkgs.gmp.override { };
    ecm = pkgs.ecm.override { };
  };
}
