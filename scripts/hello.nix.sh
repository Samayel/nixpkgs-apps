#! /usr/bin/env nix-shell
#! nix-shell -I nixpkgs=/home/johm/.nix-defexpr/channels/nixpkgs
#! nix-shell --pure -i bash -p bash hello

exec hello
