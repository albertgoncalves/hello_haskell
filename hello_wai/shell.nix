{ pkgs ? import <nixpkgs> {} }:
with pkgs; mkShell {
    name = "Wai";
    buildInputs = [ (haskell.packages.ghc843.ghcWithPackages (pkgs: [
                      pkgs.wai
                      pkgs.warp
                    ]))
                    haskellPackages.hlint
                    haskellPackages.hindent
                    libiconv
                    fzf
                  ];
    shellHook = ''
        fzfh() { find . | fzf; }
        hlintnc() { hlint -c=never $1; }
        strcd() { cd "$(dirname $1)"; }
        withfzf() {
            local h
            h=$(fzf)
            if (( $? == 0 )); then
                $1 "$h"
            fi
        }

        alias cdfzf="withfzf strcd"
        alias hlifzf="withfzf hlintnc"
        alias runfzf="withfzf runhaskell"
        alias vimfzf="withfzf vim"
        alias hindent="hindent --indent-size 4 --sort-imports --line-length 79"

        export -f fzfh
        export -f withfzf
    '';
}
