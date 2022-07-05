#! /usr/bin/env -S nix shell nixpkgs#bash nixpkgs#fortune nixpkgs#cowsay nixpkgs#lolcat -i -c bash

export PERL_BADLANG=0
exec fortune | cowsay | lolcat
