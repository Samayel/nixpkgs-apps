#! /usr/bin/env -S nix run github:Samayel/qnixpkgs#nix-fakechannel -- github:nixos/nixpkgs/release-22.05 nix shell github:nixos/nixpkgs/release-22.05#nix -c nix-shell
#! nix-shell --pure -i python3
#! nix-shell -p "python3.withPackages (pkgs: [ pkgs.prettytable ])"

#                         [nix-fakechannel source ]                  [fake nixpkgs channel => python3 src]        [nix-shell source flake            ]
#  /usr/bin/env -S nix run github:Samayel/qnixpkgs#nix-fakechannel -- github:nixos/nixpkgs/release-22.05 nix shell github:nixos/nixpkgs/release-22.05#nix -c nix-shell

import prettytable

# Print a simple table.
t = prettytable.PrettyTable(["N", "N^2"])
for n in range(1, 10): t.add_row([n, n * n])
print(t)
