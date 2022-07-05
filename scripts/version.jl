#! /usr/bin/env nix-shell
#! nix-shell -I nixpkgs=/home/johm/.nix-defexpr/channels/nixpkgs
#! nix-shell --pure -i bash -p julia-bin
#=
exec julia --color=yes --startup-file=no "${BASH_SOURCE[0]}" "$@"
=#

# https://docs.julialang.org/en/v1/manual/faq/#How-do-I-pass-options-to-julia-using-#!/usr/bin/env?

using InteractiveUtils
versioninfo()
