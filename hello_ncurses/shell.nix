{ pkgs ? import <nixpkgs> {} }:
with pkgs; mkShell {
    name = "ncurses";
    buildInputs = [ (haskell.packages.ghc843.ghcWithPackages (pkgs: [
                      pkgs.ncurses
                    ]))
                    haskellPackages.hlint
                    haskellPackages.hindent
                    libiconv
                  ];
    shellHook = ''
        alias ls='ls --color=auto'
        alias ll='ls -al'
        alias hlint=hlint -c=never
        alias hindent="hindent --indent-size 4 --sort-imports --line-length 79"
    '';
}
