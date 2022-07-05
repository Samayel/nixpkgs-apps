#! /usr/bin/env -S nix shell ./table#python3withPrettytable -i -c python3

import prettytable

# Print a simple table.
t = prettytable.PrettyTable(["N", "N^2"])
for n in range(1, 10): t.add_row([n, n * n])
print(t)
