#! /usr/bin/env -S nix shell nixpkgs#bash nixpkgs/release-22.05#julia-bin -i -c bash
#=
exec julia --color=yes --startup-file=no "${BASH_SOURCE[0]}" "$@"
=#

# https://docs.julialang.org/en/v1/manual/faq/#How-do-I-pass-options-to-julia-using-#!/usr/bin/env?

using InteractiveUtils
versioninfo()
