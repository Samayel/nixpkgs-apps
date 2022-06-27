{ stdenv, fetchgit, git, m4, gmp }:

let
  name = "${pname}-${version}";
  pname = "ggnfs";
  version = "git-" + builtins.substring 0 8 commit;
  commit = "3490572ca8671635a1b8d13a28aef3e34a657fc7";
in

stdenv.mkDerivation {
  inherit name;

  src = fetchgit {
    url = "https://github.com/radii/ggnfs";
    rev = commit;
    sha256 = "M8e6m4d25T+SJb3E/tbRTXL1RuhHupkxMiD04XEQ7kU=";
#   deepClone = true;
    leaveDotGit = true;
  };

  makepatch = ./make.patch;
  cpatch = ./c.patch;
  asmpatch = ./asm.patch;

  nativeBuildInputs = [ git m4 ];
  buildInputs = [ gmp ];

  patchPhase = ''
    runHook prePatch

    git apply $makepatch
    git apply $cpatch
    git apply $asmpatch

    runHook postPatch
  '';

  buildPhase = ''
    runHook preBuild

    make x86_64

    cd src/experimental/lasieve4_64/athlon64/
    make liblasieve.a
    make liblasieveI11.a
    make liblasieveI12.a
    make liblasieveI13.a
    make liblasieveI14.a
    make liblasieveI15.a
    make liblasieveI16.a
    cp *.a ../

    cd ../
    ln -s athlon64/ asm
    make
    cd ../../../

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp bin/* $out/bin
    cp src/experimental/lasieve4_64/gnfs-lasieve4I11e $out/bin/
    cp src/experimental/lasieve4_64/gnfs-lasieve4I12e $out/bin/
    cp src/experimental/lasieve4_64/gnfs-lasieve4I13e $out/bin/
    cp src/experimental/lasieve4_64/gnfs-lasieve4I14e $out/bin/
    cp src/experimental/lasieve4_64/gnfs-lasieve4I15e $out/bin/
    cp src/experimental/lasieve4_64/gnfs-lasieve4I16e $out/bin/

    runHook postInstall
  '';
}
