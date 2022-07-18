#!/usr/bin/env -S nix develop --impure --expr 'let pkgs = (builtins.getFlake "github:nixos/nixpkgs/release-22.05").legacyPackages.${builtins.currentSystem}; in pkgs.mkShell { packages = with pkgs; [ python3 python3Packages.prettytable ];}' -i -c python3

import prettytable

# Print a simple table.
t = prettytable.PrettyTable(["N", "N^2"])
for n in range(1, 10): t.add_row([n, n * n])
print(t)
