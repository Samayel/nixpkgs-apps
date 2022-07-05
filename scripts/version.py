#! /usr/bin/env nix-shell
#! nix-shell -I nixpkgs=/home/johm/.nix-defexpr/channels/nixpkgs
#! nix-shell --pure -i python3 -p "python39.withPackages (pkgs: [ pkgs.django ])"

import sys
print(sys.version)
