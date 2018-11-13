{ pkgs ? import <nixpkgs> {} }:

with pkgs; mkShell {
    name = "haskell";
    buildInputs = [ (haskell.packages.ghc822.ghcWithPackages (pkgs: [
                      pkgs.vector
                      pkgs.random
                      pkgs.tf-random
                      pkgs.statistics
                      pkgs.hastache
                    ]))
                    libiconv
                    fzf
                    haskellPackages.hlint
                  ];
    shellHook = ''
        withfzf() {
            local h
            h=$(fzf)
            if (( $? == 0 )); then
                $1 "$h"
            fi
        }
        hlintnc() { hlint -c=never $1; }
        alias vimfzf="withfzf vim"
        alias runfzf="withfzf runhaskell"
        alias hlifzf="withfzf hlintnc"
    '';
}
