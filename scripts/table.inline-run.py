#!/usr/bin/env -S bash -c 'cat $0 | nix run --impure --expr \'(builtins.getFlake "github:nixos/nixpkgs/release-22.05").legacyPackages.${builtins.currentSystem}.python3.withPackages (ps: with ps; [ prettytable ])\''

import prettytable

# Print a simple table.
t = prettytable.PrettyTable(["N", "N^2"])
for n in range(1, 10): t.add_row([n, n * n])
print(t)
