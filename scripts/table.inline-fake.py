#! /usr/bin/env -S nix run github:Samayel/qnixpkgs#nix-fake -- github:nixos/nixpkgs/release-22.05 nix-shell
#! nix-shell --pure -i python3
#! nix-shell -p "python3.withPackages (pkgs: [ pkgs.prettytable ])"

import prettytable

# Print a simple table.
t = prettytable.PrettyTable(["N", "N^2"])
for n in range(1, 10): t.add_row([n, n * n])
print(t)
