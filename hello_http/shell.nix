{ nixpkgs ? import <nixpkgs> {}, compiler ? "ghc844" }:

let

    inherit (nixpkgs) pkgs;

    f = { mkDerivation, base, stdenv }:
        mkDerivation {
            pname = "haskell";
            version = "0";
            src = ./.;
            isLibrary = false;
            isExecutable = true;
            executableHaskellDepends = [ base
                                         haskellPackages.http-conduit
                                         haskellPackages.HTTP
                                         haskellPackages.tagsoup
                                       ];
            license = stdenv.lib.licenses.gpl3;
        };

    haskellPackages = if compiler == "default"
                          then pkgs.haskellPackages
                      else
                          pkgs.haskell.packages.${compiler};

    drv = haskellPackages.callPackage f {};

in

    if pkgs.lib.inNixShell
        then drv.env
    else drv
