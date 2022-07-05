self: super:
{
  # this key should be the same as the flake name attribute.
  table-flake = {
    python3withPrettytable = super.python3.withPackages (pkgs: [ pkgs.prettytable ]);
  };
}
