#! /usr/bin/env nix-shell
#! nix-shell -I nixpkgs=https://github.com/NixOS/nixpkgs/archive/87d9c84817d7be81850c07e8f6a362b1dfc30feb.tar.gz
#! nix-shell --pure -i bash -p bash hello

exec hello
